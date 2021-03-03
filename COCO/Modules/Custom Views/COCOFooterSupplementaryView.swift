//
//  COCOFooterSupplementaryView.swift
//  COCO
//
//  Created by Tuyen Le on 2/26/21.
//
//  Footer View to display loading indicator & end of result label

import UIKit

class COCOFooterSupplementaryView: UICollectionReusableView {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView! {
        didSet {
            loadingIndicator.startAnimating()
        }
    }
    @IBOutlet weak var endOfResultLabel: UILabel!
}
