//
//  COCOSearchController.swift
//  COCO
//
//  Created by Tuyen Le on 3/1/21.
//

import UIKit
import RxSwift

class COCOSearchController: UISearchController {
    
    let searchResult: COCOSearchResultTableController
    
    let categoriesLookup: BehaviorSubject<[String]> = BehaviorSubject(value: NetworkConstants.categories)
    
    let selectedCategoryTokens: BehaviorSubject<[String]> = BehaviorSubject(value: [])
    
    init() {
        searchResult = COCOSearchResultTableController(categoriesLookup: categoriesLookup, selectedCategories: selectedCategoryTokens)
        
        super.init(searchResultsController: searchResult)
        
        searchBar.placeholder = "Search And Select Categories"
        searchBar.returnKeyType = .search
        searchBar.autocapitalizationType = .none
        searchBar.searchTextField.allowsDeletingTokens = false
        searchBar.searchTextField.allowsCopyingTokens = false
        searchBar.searchTextField.clearButtonMode = .never
        
        hidesNavigationBarDuringPresentation = false
        showsSearchResultsController = true
        
        self.setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let selectedCategories = try! selectedCategoryTokens.value()
        if searchBar.searchTextField.tokens.isEmpty, !selectedCategories.isEmpty {
            for category in selectedCategories {
                let categoryToken = UISearchToken(icon: nil, text: category)
                categoryToken.representedObject = category
                searchBar.searchTextField.tokens.append(categoryToken)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        searchResult = COCOSearchResultTableController(categoriesLookup: categoriesLookup, selectedCategories: selectedCategoryTokens)
        super.init(coder: coder)
    }
}

extension COCOSearchController {
    func setupBinding() {
        searchResult
            .tableView
            .rx
            .itemSelected
            .asDriver()
            .drive(onNext: { indexPath in
                let category = try! self.categoriesLookup.value()[indexPath.row]
                let categoryToken = UISearchToken(icon: nil, text: category)
                categoryToken.representedObject = category
                
                self.searchBar.searchTextField.tokens.append(categoryToken)
                
                var selectedCategories = try! self.selectedCategoryTokens.value()
                selectedCategories.append(category)
                
                self.selectedCategoryTokens.onNext(selectedCategories)
            })
            .disposed(by: rx.disposeBag)
        

        searchResult
            .tableView
            .rx
            .itemDeselected
            .asDriver()
            .drive(onNext: { removeIndexPath in
                let category = try! self.categoriesLookup.value()[removeIndexPath.row]
                var selectedCategories = try! self.selectedCategoryTokens.value()

                self.searchBar.searchTextField.tokens.removeAll(where: { $0.representedObject as? String == category })

                selectedCategories.removeAll(where: { $0 == category })
                self.selectedCategoryTokens.onNext(selectedCategories)
                
            })
            .disposed(by: rx.disposeBag)
        
        searchBar
            .rx
            .text
            .asDriver()
            .unwrap()
            .drive(onNext: { searchText in
                if searchText.isEmpty {
                    self.categoriesLookup.onNext(NetworkConstants.categories)
                } else {
                    let categories = NetworkConstants.categories.filter { $0.contains(searchText) }
                    self.categoriesLookup.onNext(categories)
                }
            })
            .disposed(by: rx.disposeBag)
        
        searchBar
            .rx
            .searchButtonClicked
            .withLatestFrom(selectedCategoryTokens.asObserver())
            .asDriver(onErrorDriveWith: .empty())
            .do(onNext: { _ in
                self.searchBar.text = ""
            })
            .filter { !$0.isEmpty }
            .drive(onNext: { _ in
                self.dismiss(animated: true)
            })
            .disposed(by: rx.disposeBag)

    }
}

