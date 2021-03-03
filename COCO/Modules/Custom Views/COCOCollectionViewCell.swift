//
//  COCOCollectionViewCell.swift
//  COCO
//
//  Created by Tuyen Le on 2/26/21.
//
//  Render COCO Image, Image captions & links and Categories for selection
//  When tap on a category, it will draw that category segmentation

import UIKit
import SDWebImage
import RxCocoa
import RxSwift

class COCOCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var linksURL: UILabel!
    @IBOutlet weak var imageInfoCollectionView: UICollectionView! {
        didSet {
            imageInfoCollectionView.collectionViewLayout = UICollectionViewLayout.category(width: 0.5)
            imageInfoCollectionView.allowsMultipleSelection = true
            imageInfoCollectionView.dataSource = nil
            imageInfoCollectionView.register(UINib(nibName: String(describing: COCOCategoryCollectionViewCell.self), bundle: nil),
                                             forCellWithReuseIdentifier: "image info")
        }
    }
    @IBOutlet weak var categoryCollectionView: UICollectionView! {
        didSet {
            categoryCollectionView.collectionViewLayout = UICollectionViewLayout.category()
            categoryCollectionView.allowsMultipleSelection = true
            categoryCollectionView.register(UINib(nibName: String(describing: COCOCategoryCollectionViewCell.self), bundle: nil),
                                            forCellWithReuseIdentifier: "category")
        }
    }
    @IBOutlet weak var imageView: COCOUIIMageView! {
        didSet {
            imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        }
    }
    
    var categorySelectDisposable: Disposable?
    var categoryDeselectDisposable: Disposable?
    var categoryDisposable: Disposable?
    
    var firstCategorySelectDisposable: Disposable?
    
    var imageInfoDisposable: Disposable?
    var imageInfoSelect: Disposable?
    var imageInfoDeslect: Disposable?
    
    let imageInfoBind: Observable<[Int]> = Observable.just([91, 0])
    
    override func prepareForReuse() {
        categoryCollectionView.isHidden = true
        
        captionLabel.text = ""
        linksURL.text = ""
        
        imageView.image = nil
        imageView.originalImage = nil
        imageView.categorySegmentations.removeAll()
        imageView.categoryColor.removeAll()
        
        
        firstCategorySelectDisposable?.dispose()
        
        categorySelectDisposable?.dispose()
        categoryDeselectDisposable?.dispose()
        categoryDisposable?.dispose()
        
        imageInfoDisposable?.dispose()
        imageInfoSelect?.dispose()
        imageInfoDeslect?.dispose()
    }
    
    func display(imageResult: ImageResult, at: IndexPath) {
        guard let url = imageResult.datas.first?.cocoURL else {
            return
        }
        
        let categoriesWithSegmentations = imageResult.categoriesWithSegmentations
        let categoriesId = Array(categoriesWithSegmentations.keys)

        // Get coco image
        imageView.sd_setImage(with: URL(string: url)) { _, _, _, _ in
            self.categoryCollectionView.isHidden = false
            
            // Draw all categories segmentations
            for (categoryId, segmentations) in categoriesWithSegmentations {
                self.imageView.drawCategory(id: categoryId, segmentations: segmentations)
            }
        }

        
        // URL & Sentence cell select/deselect
        imageInfoSelect = imageInfoCollectionView
            .rx
            .itemSelected
            .asDriver(onErrorJustReturn: .init())
            .drive(onNext: { indexPath in
                if indexPath.row == 0 {
                    self.linksURL.text = imageResult.linksURL
                } else {
                    self.captionLabel.text = imageResult.captionSentence
                }
            })

        imageInfoDeslect = imageInfoCollectionView
            .rx
            .itemDeselected
            .asDriver(onErrorJustReturn: .init())
            .drive(onNext: { indexPath in

                if indexPath.row == 0 {
                    self.linksURL.text = ""
                } else {
                    self.captionLabel.text = ""
                }
            })

        // On first selection, remove all categories' segmentation except the one selected
        firstCategorySelectDisposable = categoryCollectionView
            .rx
            .itemSelected
            .take(1)
            .asDriver(onErrorJustReturn: .init())
            .drive(onNext: { indexPath in
                let firstSelectedCategory = categoriesId[indexPath.row]
                let cell = self.categoryCollectionView.cellForItem(at: indexPath) as? COCOCategoryCollectionViewCell

                cell?.layer.borderColor = self.imageView.categoryColor[firstSelectedCategory]

                for categoryId in categoriesId where categoryId != firstSelectedCategory {
                    self.imageView.removeCategory(id: categoryId)
                }
            })
        
        // Draw category's segmentation on subsequent selections
        categorySelectDisposable = categoryCollectionView
            .rx
            .itemSelected
            .skip(1)
            .asDriver(onErrorJustReturn: .init())
            .drive(onNext: { indexPath in
                let selectedCategoryId = categoriesId[indexPath.row]
                let segmentations = categoriesWithSegmentations[selectedCategoryId] ?? []
                let cell = self.categoryCollectionView.cellForItem(at: indexPath) as? COCOCategoryCollectionViewCell

                
                self.imageView.drawCategory(id: selectedCategoryId, segmentations: segmentations)
                
                cell?.layer.borderColor = self.imageView.categoryColor[selectedCategoryId]
            })
        
        // Remove draw category from image
        categoryDeselectDisposable = categoryCollectionView
            .rx
            .itemDeselected
            .asDriver(onErrorJustReturn: .init())
            .drive(onNext: { indexPath in
                let deselectCategoryId = categoriesId[indexPath.row]
                
                let cell = self.categoryCollectionView.cellForItem(at: indexPath) as? COCOCategoryCollectionViewCell

                cell?.layer.borderColor = UIColor.white.cgColor
                
                self.imageView.removeCategory(id: deselectCategoryId)
            })
        
        // Display categories cell
        categoryCollectionView.dataSource = nil
        categoryDisposable = Observable<[Int]>
            .just(categoriesId)
            .bind(to: categoryCollectionView.rx.items(cellIdentifier: "category")) { _, categoryId, cell in
                guard let categoryCell = cell as? COCOCategoryCollectionViewCell else {
                    fatalError("Expecting COCO Category Cell but found nil")
                }

                categoryCell.displayImageFor(categoryId: categoryId)
            }
        
        // Display image information cell (url link & caption)
        imageInfoDisposable = imageInfoBind
            .bind(to: imageInfoCollectionView.rx.items(cellIdentifier: "image info")) { _, categoryId, cell in
                guard let categoryCell = cell as? COCOCategoryCollectionViewCell else {
                    fatalError("Expecting COCO Category Cell but found nil")
                }

                categoryCell.displayImageFor(categoryId: categoryId)
            }

    }
}
