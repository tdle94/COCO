//
//  UIScrollView+.swift
//  COCO
//
//  Created by Tuyen Le on 2/26/21.
//

import UIKit

extension UIScrollView {
    var isAtBottom: Bool {
        return contentOffset.y + frame.size.height + 20 > contentSize.height
    }
}
