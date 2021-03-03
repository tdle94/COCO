//
//  COCORepositoryImplementation.swift
//  COCO
//
//  Created by Tuyen Le on 2/25/21.
//

import Moya
import RxSwift

class COCORepositoryImplementation: COCORepository {
    
    let service: COCOService
    
    init(service: COCOService) {
        self.service = service
    }
    
    func categories(ids: [Int]) -> Single<[Int]> {
        return service.categories(ids: ids).map([Int].self)
    }
    
    func getImageData(ids: [Int]) -> Single<[ImageData]> {        
        return service.getImageData(ids: ids, type: .getImages).map([ImageData].self)
    }
    
    func getImageInstance(ids: [Int]) -> Single<[ImageInstance]> {
        return service.getImageData(ids: ids, type: .getInstances).map([ImageInstance].self)
    }
    
    func getImageCaption(ids: [Int]) -> Single<[ImageCaption]> {
        return service.getImageData(ids: ids, type: .getCaptions).map([ImageCaption].self)
    }
}
