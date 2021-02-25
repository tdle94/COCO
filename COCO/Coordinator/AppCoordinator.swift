//
//  AppCoordinator.swift
//  COCO
//
//  Created by Tuyen Le on 2/25/21.
//

import Foundation
import Swinject

class AppCoordinator: Coordinator {
    let window: UIWindow
    let container: Container
    
    var currentView: UIViewController?
    
    init(window: UIWindow, container: Container) {
        self.window = window
        self.window.rootViewController = UINavigationController(rootViewController: container.resolve(MainView.self)!)
        self.container = container
    }
    
    func start() {
        showMainView()
    }
    
    fileprivate func showMainView() {
        let view = container.resolve(MainView.self)!
        self.currentView = view
    }
}
