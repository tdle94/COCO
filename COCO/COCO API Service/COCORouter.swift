//
//  Router.swift
//  COCO
//
//  Created by Tuyen Le on 2/25/21.
//

import Moya

enum ImageDataType: String {
    case getImages = "getImages"
    case getInstances = "getInstances"
    case getCaptions = "getCaptions"
}

enum COCORouter {
    case categories([Int])
    case getImageData([Int], ImageDataType)
}

extension COCORouter: TargetType {
    var baseURL: URL {
        return URL(string: NetworkConstants.searchURL)!
    }
    
    var path: String {
        switch self {
        case .categories, .getImageData:
            return NetworkConstants.path
        }
    }
    
    var method: Method {
        return .post
    }
    
    var sampleData: Data {
        switch self {
        case .categories:
            return arrayJsonSerializedUTF8(json: [99984, 539934, 106537, 408217, 42070])
        case .getImageData(_, let dataType):
            if dataType == .getImages {
                return jsonSerializedUTF8(json: [
                    "id": 99984,
                    "coco_url": "http://images.cocodataset.org/train2017/000000099984.jpg",
                    "flickr_url": "http://farm2.staticflickr.com/1422/1362784880_534acb2e8e_z.jpg"
                ])
            } else if dataType == .getInstances {
                return jsonSerializedUTF8(json: [
                    "image_id": 99984,
                    "segmentation": "[[323.01, 83.1, 325.87, 34.99, 304.11, 34.99, 298.95, 75.65, 298.95, 81.95]]",
                    "category_id": 10
                ])
            }
            return jsonSerializedUTF8(json: [
                "caption": "a couple of different types of signs on the outside",
                "image_id": 99984
            ])
        }
    }
    
    
    
    var task: Task {
        switch self {
        case .categories(let id):
            return .requestParameters(parameters: ["category_ids": id, "querytype": "getImagesByCats"], encoding: JSONEncoding.default)
        case .getImageData(let ids, let type):
            return .requestParameters(parameters: ["image_ids": ids, "querytype": type.rawValue], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
    func arrayJsonSerializedUTF8(json: [Int]) -> Data {
        do {
            return try JSONSerialization.data(
                withJSONObject: json,
                options: [.prettyPrinted]
            )
        } catch {
            return Data()
        }
    }
    
    func jsonSerializedUTF8(json: [String: Any]) -> Data {
        do {
            return try JSONSerialization.data(
                withJSONObject: json,
                options: [.prettyPrinted]
            )
        } catch {
            return Data()
        }
    }
    
}
