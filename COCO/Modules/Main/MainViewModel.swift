//
//  MainViewModel.swift
//  COCO
//
//  Created by Tuyen Le on 2/25/21.
//

import RxSwift
import RxCocoa
import RxSwiftExt
import RxDataSources

class MainViewModel {
    
    let disposeBag = DisposeBag()
    
    let categoryQuery: Observable<[String]>
    let imageResults: BehaviorSubject<[SectionModel<String, ImageResult>]> = BehaviorSubject(value: [])
    
    let isLoading: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    let loadNextPage: PublishSubject<Bool> = PublishSubject()
    let hideEndOfResult: PublishSubject<Bool> = PublishSubject()
    let backgroundLabel: PublishSubject<String> = PublishSubject()
    let totalImageResultLabel: PublishSubject<String> = PublishSubject()
    
    init(categoryQuery: Driver<[String]>, repository: COCORepository, localStorage: LocalStorage) {
        
        // search
        self.categoryQuery = categoryQuery.asObservable().filter { !$0.isEmpty }
        
        // get image ids according to category
        let imageIds = self.categoryQuery
            .do()
            .flatMapLatest { category -> Observable<Event<Array<Int>>> in
                
                self.isLoading.onNext(true)
                self.hideEndOfResult.onNext(true)
                self.backgroundLabel.onNext("")
                self.totalImageResultLabel.onNext("")
                
                self.imageResults.onNext([.init(model: "coco", items: [])])
                
                return repository
                    .categories(ids: category.compactMap { NetworkConstants.categoryToId[$0] })
                    .asObservable()
                    .catchError { error in
                        self.isLoading.onNext(false)
                        self.backgroundLabel.onNext(error.localizedDescription)
                        return Observable<[Int]>.error(COCOError(message: error.localizedDescription))
                    }
                    .materialize()
            }
            .share()
        
        // get image data, caption and instance from search after obtained image ids
        let imageDataFetchResult = imageIds
            .elements()
            .asObservable()
            .do(onNext: { ids in
                localStorage.categoryIds = ids
                if ids.isEmpty {
                    self.hideEndOfResult.onNext(true)
                    self.isLoading.onNext(false)
                    self.backgroundLabel.onNext("No result found")
                }
            })
            .filter { !$0.isEmpty }
            .flatMapLatest { _ -> Observable<Event<PrimitiveSequence<SingleTrait, (Array<ImageData>, Array<ImageCaption>, Array<ImageInstance>)>>> in
                let ids = localStorage.nextIdsPage

                return Single.zip(Single.just(repository.getImageData(ids: ids)),
                                  Single.just(repository.getImageCaption(ids: ids)),
                                  Single.just(repository.getImageInstance(ids: ids)))
                        { Single.zip($0, $1, $2) }
                    .asObservable()
                    .share()
                    .materialize()
            }
            .share()
            
        // Return image data result
        imageDataFetchResult
            .elements()
            .catchError { error in
                self.isLoading.onNext(false)
                return .error(COCOError(message: error.localizedDescription))
            }
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: {
                $0
                    .asDriver(onErrorDriveWith: .empty())
                    .drive(onNext: { result in
                        let (imageDatas, imageCaptions, imageInstances) = result
                        let imageResults = self.createImageResultFrom(imageDatas: imageDatas,
                                                                      imageCaptions: imageCaptions,
                                                                      imageInstances: imageInstances)
                        
                        localStorage.incrementIdPage()
                        
                        self.totalImageResultLabel.onNext(String(localStorage.categoryIds.count) + " results")
                        self.isLoading.onNext(false)
                        self.imageResults
                            .onNext([.init(model: "coco", items: imageResults)])
                    })
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: self.disposeBag)
        
        // load next image data result page when scroll down to bottom of the view
        loadNextPage
            .filter { isAtBottom in (try! !self.isLoading.value()) && isAtBottom }
            .do(onNext: { _ in
                self.hideEndOfResult.onNext(true)
                self.isLoading.onNext(true)
            })
            .subscribe { _ in
                let ids = localStorage.nextIdsPage

                Single
                    .zip(Single.just(repository.getImageData(ids: ids)),
                         Single.just(repository.getImageCaption(ids: ids)),
                         Single.just(repository.getImageInstance(ids: ids))) { Single.zip($0, $1, $2) }
                    .filter { _ in
                        if ids.isEmpty {
                            self.hideEndOfResult.onNext(false)
                            self.isLoading.onNext(false)
                        }
                        return !ids.isEmpty
                    }
                    .asObservable()
                    .share()
                    .materialize()
                    .asDriver(onErrorJustReturn: .error(COCOError(message: "Cannot get image datas")))
                    .drive(onNext: {
                        $0
                            .element?
                            .catchError { error in
                                self.isLoading.onNext(false)
                                return .error(COCOError(message: error.localizedDescription))
                            }
                            .asDriver(onErrorDriveWith: .empty())
                            .drive(onNext: { result in
                                let (imageDatas, imageCaptions, imageInstances) = result
                                
                                let imageResults = self.createImageResultFrom(imageDatas: imageDatas,
                                                                              imageCaptions: imageCaptions,
                                                                              imageInstances: imageInstances)

                                let previousImageResults = try! self.imageResults.value().first?.items ?? []

                                self.isLoading.onNext(false)
                                
                                localStorage.incrementIdPage()
                                self.imageResults
                                    .onNext([.init(model: "coco", items: previousImageResults + imageResults)])
                            })
                            .disposed(by: self.disposeBag)

                    })
                    .disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)
    }
    
    private func createImageResultFrom(imageDatas: [ImageData], imageCaptions: [ImageCaption], imageInstances: [ImageInstance]) -> [ImageResult] {
        var imageResultDict: [Int : ImageResult] = [:]

        for imageData in imageDatas {
            if imageResultDict[imageData.id] == nil {
                imageResultDict[imageData.id] = ImageResult(id: imageData.id)
            }

            imageResultDict[imageData.id]?.datas.append(imageData)
        }

        for imageCaption in imageCaptions {
            imageResultDict[imageCaption.imageId]?.captions.append(imageCaption)
        }

        for imageInstance in imageInstances {
            imageResultDict[imageInstance.imageId]?.instances.append(imageInstance)
        }

        return Array(imageResultDict.values)
    }
}
