//
//  MainView.swift
//  COCO
//
//  Created by Tuyen Le on 2/25/21.
//

import UIKit
import RxSwift
import RxCocoa

class MainView: UIViewController {
    
    @IBOutlet weak var collectionView: COCOCollectionView!
    
    let searchController: COCOSearchController = COCOSearchController()

    let viewModel: MainViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        setupSearchBar()
    }
    
    init(repository: COCORepository, localStorage: LocalStorage) {
        let search = searchController
            .searchBar
            .rx
            .searchButtonClicked
            .withLatestFrom(searchController.selectedCategoryTokens)
            .asDriver(onErrorJustReturn: [])
        
        viewModel = MainViewModel(categoryQuery: search,
                                  repository: repository,
                                  localStorage: localStorage)
        super.init(nibName: String(describing: MainView.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainView {
    func setupSearchBar() {
        navigationItem.titleView = searchController.searchBar
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
    }
    
    func setupBinding() {
        viewModel
            .imageResults
            .bind(to: collectionView.rx.items(dataSource: collectionView.cocoDataSource))
            .disposed(by: rx.disposeBag)

        collectionView
            .rx
            .contentOffset
            .asDriver()
            .filter { _ in self.collectionView.numberOfSections != 0 }
            .flatMap { _ in
                Signal.just(self.collectionView.isAtBottom)
            }
            .asDriver(onErrorJustReturn: false)
            .filter { $0 }
            .drive(onNext: { isAtBottom in
                self.viewModel.loadNextPage.onNext(isAtBottom)
            })
            .disposed(by: rx.disposeBag)
        
        collectionView
            .rx
            .willDisplaySupplementaryView
            .take(2)
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { event in
                
                if let header = event.supplementaryView as? COCOHeaderSupplementaryView {
                    self.viewModel
                        .totalImageResultLabel
                        .bind(to: header.totalImageResultLabel.rx.text)
                        .disposed(by: self.rx.disposeBag)
                } else if let footer = event.supplementaryView as? COCOFooterSupplementaryView {
                    self.viewModel
                        .isLoading
                        .bind(to: footer.loadingIndicator.rx.isAnimating)
                        .disposed(by: self.rx.disposeBag)
                    
                    self.viewModel
                        .hideEndOfResult
                        .bind(to: footer.endOfResultLabel.rx.isHidden)
                        .disposed(by: self.rx.disposeBag)
                }
            })
            .disposed(by: rx.disposeBag)
        
        
        viewModel
            .backgroundLabel
            .bind(to: collectionView.backgroundLabel.rx.text)
            .disposed(by: rx.disposeBag)
    }
}
