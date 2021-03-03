//
//  COCOCategoryCollectionViewCell.swift
//  COCO
//
//  Created by Tuyen Le on 2/27/21.
//

import UIKit
import SDWebImage

class COCOCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryImageView: UIImageView! {
        didSet {
            categoryImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            categoryImageView.contentMode = .scaleToFill
        }
    }
    
    override var isSelected: Bool {
        didSet {
            layer.borderWidth = isSelected ? 5 : 0
        }
    }
    
    func displayImageFor(categoryId: Int) {
        guard
            let category = NetworkConstants.idToCategory[categoryId],
            let url = NetworkConstants.cocoicons[category]
        else { return }

        categoryImageView.sd_setImage(with: URL(string: url))
    }
}
