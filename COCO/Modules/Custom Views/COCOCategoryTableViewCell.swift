//
//  COCOCategoryTableViewCell.swift
//  COCO
//
//  Created by Tuyen Le on 3/1/21.
//
//  Render Category title & image for tableView

import UIKit
import SDWebImage

class COCOCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView! {
        didSet {
            categoryImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        }
    }

    override func prepareForReuse() {
        categoryImageView.image = nil
        categoryLabel.text = ""
        accessoryType = .none
    }
    
    func displayCategory(_ category: String) {
        categoryLabel.text = category
        
        if let logo = NetworkConstants.cocoicons[category] {
            categoryImageView.sd_setImage(with: URL(string: logo))
        }
    }
}
