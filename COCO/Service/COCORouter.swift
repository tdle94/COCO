//
//  Router.swift
//  COCO
//
//  Created by Tuyen Le on 2/25/21.
//

import Moya

enum Router {
    case categories(Int)
    case search(String)
}

extension Router: TargetType {
    var baseURL: URL {
        return URL(string: NetworkConstants.searchURL)!
    }
    
    var path: String {
        switch self {
        case .categories, .search:
            return NetworkConstants.path
        }
    }
    
    var method: Method {
        return .post
    }
    
    var sampleData: Data {
        let data = [99984, 539934, 106537, 408217, 42070]
        return arrayJsonSerializedUTF8(json: data)
    }
    
    
    
    var task: Task {
        switch self {
        case .categories(let id):
            return .requestParameters(parameters: ["category_ids": id, "querytype": "getImagesByCats"], encoding: JSONEncoding.default)
        case .search(let query):
            return .requestParameters(parameters: ["category_ids": query, "querytype": "getImagesByCats"], encoding: JSONEncoding.default)
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
    
}
