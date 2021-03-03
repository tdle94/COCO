//
//  COCOARepository.swift
//  COCO
//
//  Created by Tuyen Le on 2/25/21.
//

import RxSwift
import Moya

protocol COCORepository: class {
    func categories(ids: [Int]) -> Single<[Int]>
    func getImageData(ids: [Int]) -> Single<[ImageData]>
    func getImageInstance(ids: [Int]) -> Single<[ImageInstance]>
    func getImageCaption(ids: [Int]) -> Single<[ImageCaption]>
}

struct COCOError: LocalizedError {
    let message: String
    
    init(message: String = "Error!") {
        self.message = message
    }
    
    var errorDescription: String? {
        return self.message
    }
}
