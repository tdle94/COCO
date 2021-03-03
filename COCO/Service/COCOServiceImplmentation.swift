//
//  ServiceImplmentation.swift
//  COCO
//
//  Created by Tuyen Le on 2/25/21.
//

import RxSwift
import Moya
import RxSwift

struct COCOServiceImplementation: COCOService {
    
    let provider: MoyaProvider<COCORouter>
    
    init(provider: MoyaProvider<COCORouter>) {
        self.provider = provider
    }
    
    func categories(ids: [Int]) -> Single<Response> {
        return provider.rx.request(.categories(ids))
    }
    
    func getImageData(ids: [Int], type: ImageDataType) -> Single<Response> {
        return provider.rx.request(.getImageData(ids, type))
    }
}
