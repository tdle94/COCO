//
//  COCOSearchResultTableController.swift
//  COCO
//
//  Created by Tuyen Le on 3/1/21.
//

import UIKit
import RxSwift

class COCOSearchResultTableController: UITableViewController {
    
    init(categoriesLookup: Observable<[String]>, selectedCategories: BehaviorSubject<[String]>) {
        super.init(nibName: nil, bundle: nil)
        
        let emptyLabel = UILabel()
        emptyLabel.text = "Not Found"
        emptyLabel.textAlignment = .center
        emptyLabel.textColor = .black

        tableView.backgroundView = emptyLabel
        tableView.tableFooterView = UIView()
        tableView.allowsMultipleSelection = true
        tableView.rowHeight = 60
        tableView.dataSource = nil
        tableView.backgroundColor = .white
        tableView.register(UINib(nibName: String(describing: COCOCategoryTableViewCell.self), bundle: nil), forCellReuseIdentifier: "category")
            
        
        categoriesLookup
            .do(onNext: { categories in
                emptyLabel.isHidden = !categories.isEmpty
            })
            .bind(to: tableView.rx.items(cellIdentifier: "category")) { row, category, cell in
                guard let categoryCell = cell as? COCOCategoryTableViewCell else { return }
                categoryCell.displayCategory(category)

                if try! selectedCategories.value().contains(category) {
                    self.tableView.selectRow(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: .none)
                    categoryCell.accessoryType = .checkmark
                }
            }
            .disposed(by: rx.disposeBag)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
