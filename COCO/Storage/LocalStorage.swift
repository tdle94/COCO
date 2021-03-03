//
//  LocalStorage.swift
//  COCO
//
//  Created by Tuyen Le on 2/25/21.
//

import Foundation

protocol LocalStorage: class {
    var currentPage: Int { get }
    var categoryIds: [Int] { get set }
    var nextIdsPage: [Int] { get }
    
    func incrementIdPage()
}
