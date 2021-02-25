//
//  MainView.swift
//  COCO
//
//  Created by Tuyen Le on 2/25/21.
//

import UIKit

class MainView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    init() {
        super.init(nibName: String(describing: MainView.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
