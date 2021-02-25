//
//  DefaultContainer.swift
//  COCO
//
//  Created by Tuyen Le on 2/25/21.
//

import Foundation
import Swinject

final class DefaultContainer {
    
    let container: Container
    
    init() {
        self.container = Container()
        self.registerViews()
    }
    
}

extension DefaultContainer {
    func registerViews() {
        self.container.register(MainView.self) { resolver in
            MainView()
        }
    }
}
