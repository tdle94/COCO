//
//  Service.swift
//  COCO
//
//  Created by Tuyen Le on 2/25/21.
//

import RxSwift
import Moya

protocol COCOService {
    func categories(ids: [Int]) -> Single<Response>
    func getImageData(ids: [Int], type: ImageDataType) -> Single<Response>
}
