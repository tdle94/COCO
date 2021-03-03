//
//  ImageResponse.swift
//  COCO
//
//  Created by Tuyen Le on 2/25/21.
//

import Foundation

struct ImageCaption: Decodable {
    let caption: String
    let imageId: Int
    
    enum CodingKeys: String, CodingKey {
        case caption
        case imageId = "image_id"
    }
}

struct ImageInstance: Decodable {
    let imageId: Int
    let segmentation: String
    let segmentations: [Double]
    let categoryId: Int
    
    struct DiffSegmentation: Decodable {
        let counts: [Double]
        let size: [Int]
    }
    
    enum CodingKeys: String, CodingKey {
        case segmentation
        case categoryId = "category_id"
        case imageId = "image_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        imageId = try container.decode(Int.self, forKey: .imageId)
        categoryId = try container.decode(Int.self, forKey: .categoryId)
        segmentation = try container.decode(String.self, forKey: .segmentation)
        
        if let segmentationData = segmentation.data(using: .utf8) {
            let jsonDecoder = JSONDecoder()
            
            do {
                segmentations = try jsonDecoder.decode([[Double]].self, from: segmentationData).first ?? []
            } catch {
                
                do {
                    segmentations = try jsonDecoder.decode(DiffSegmentation.self, from: segmentationData).counts
                } catch let jsonError {
                    segmentations = []
                    debugPrint("Cannot decode segmentation data: \(jsonError.localizedDescription)")
                }

            }
        } else {
            segmentations = []
            debugPrint("no Segmentation data")
        }
        
    }
}


struct ImageData: Decodable {
    let id: Int
    let cocoURL: String
    let flickrURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case cocoURL = "coco_url"
        case flickrURL = "flickr_url"
    }
}

struct ImageResult {
    let id: Int
    var datas: [ImageData] = []
    var instances: [ImageInstance] = []
    var captions: [ImageCaption] = []
    
    var categoriesWithSegmentations: [Int : [[Double]]] {
        var hash: [ Int : [[Double]] ] = [:]
        
        for instance in instances {
            if hash[instance.categoryId] == nil {
                hash[instance.categoryId] = []
            }
            
            hash[instance.categoryId]?.append(instance.segmentations)
        }
        
        return hash
    }
    
    var linksURL: String? {
        if let cocoURL = datas.first?.cocoURL, let flickrURL = datas.first?.flickrURL {
            return cocoURL + "\n" + flickrURL
        }

        return datas.first?.cocoURL ?? datas.first?.flickrURL
    }
    
    var captionSentence: String {
        return captions.map { $0.caption }.joined(separator: "\n")
    }
    
    init(id: Int) {
        self.id = id
    }
}
