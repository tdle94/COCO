//
//  DefaultContainer.swift
//  COCO
//
//  Created by Tuyen Le on 2/25/21.
//

import Foundation
import Swinject
import Moya

final class DefaultContainer {
    
    let container: Container
    
    init() {
        self.container = Container()
        self.registerViews()
        self.registerRepositories()
        self.registerService()
    }
    
}

extension DefaultContainer {
    func registerViews() {
        self.container.register(MainView.self) { resolver in
            MainView(repository: resolver.resolve(COCORepository.self)!,
                     localStorage: resolver.resolve(LocalStorage.self)!)
        }
    }
    
    func registerRepositories() {
        self.container.register(COCORepository.self) { resolver in
            COCORepositoryImplementation(service: resolver.resolve(COCOService.self)!)
        }
        
        self.container.register(LocalStorage.self) { resolver in
            LocalSotrageImplementation()
        }
    }
    
    func registerService() {
        self.container.register(COCOService.self) { resolver in
            let provider = MoyaProvider<COCORouter>(plugins: self.getDefaultPlugins())
            return COCOServiceImplementation(provider: provider)
        }
    }
    
    func getDefaultPlugins() -> [PluginType] {
        #if DEBUG
            return [NetworkLoggerPlugin(verbose: true)]
        #else
            return []
        #endif
    }
}
