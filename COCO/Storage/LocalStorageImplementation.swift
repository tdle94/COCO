//
//  LocalStorageImplementation.swift
//  COCO
//
//  Created by Tuyen Le on 2/25/21.
//
//  We will paginate image IDs for 5 ids per request/page. We don't want to
//  display everything in the collection view because that will slow down the app

import Foundation

class LocalSotrageImplementation: LocalStorage {
    let numberOfIdPerPage = 5
    
    let userDefaults: UserDefaults
    
    var currentPage: Int {
        return userDefaults.integer(forKey: LocalStorageKeys.currentPage)
    }
    
    var imageIds: [Int] {
        get {
            return userDefaults.array(forKey: LocalStorageKeys.categoryIds) as? [Int] ?? []
        }
        set {
            userDefaults.setValue(newValue, forKey: LocalStorageKeys.categoryIds)
            resetPage() // reset page to 0 when setting new category ids
        }
    }
    
    var nextImageIdsPage: [Int] {
        guard
            let ids = userDefaults.array(forKey: LocalStorageKeys.categoryIds) as? [Int],
            !ids.isEmpty,
            currentPage * numberOfIdPerPage < ids.count
        else {
            return []
        }
        
        let start = currentPage * numberOfIdPerPage
        var end = (currentPage + 1) * numberOfIdPerPage - 1
        
        if end >= ids.count {
            end = ids.endIndex - 1
        }
        
        let partition = ids[start...end]
        
        return Array(partition)
    }
    
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
        userDefaults.register(defaults: [LocalStorageKeys.currentPage : 0])
        userDefaults.register(defaults: [LocalStorageKeys.categoryIds: []])
    }
    
    func incrementIdPage() {
        userDefaults.setValue(currentPage + 1, forKey: LocalStorageKeys.currentPage)
    }
    
    func resetPage() {
        userDefaults.setValue(0, forKey: LocalStorageKeys.currentPage)
    }
}
