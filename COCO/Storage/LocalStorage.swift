//
//  LocalStorage.swift
//  COCO
//
//  Created by Tuyen Le on 2/25/21.
//
//  We will paginate image IDs for 5 ids per request/page. By storing
//  all the image IDs with the current page locally so next time we
//  can retrieve more image IDs if needed

import Foundation

protocol LocalStorage: class {
    var currentPage: Int { get }
    var imageIds: [Int] { get set }
    var nextImageIdsPage: [Int] { get }
    
    func incrementIdPage()
}
