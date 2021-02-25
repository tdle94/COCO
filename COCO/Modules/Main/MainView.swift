//
//  MainView.swift
//  COCO
//
//  Created by Tuyen Le on 2/25/21.
//

import UIKit

class MainView: UIViewController {
    
    let searchController: UISearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.titleView = searchController.searchBar
    }
    
    init() {
        super.init(nibName: String(describing: MainView.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
