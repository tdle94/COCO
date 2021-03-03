//
//  Constant.swift
//  COCO
//
//  Created by Tuyen Le on 2/25/21.
//

import Foundation

struct NetworkConstants {
    static let searchURL = "https://us-central1-open-images-dataset.cloudfunctions.net"
    static let path = "/coco-dataset-bigquery"
    
    static let categoryToId = [
        "sentences": 0, "toilet": 70, "teddy bear": 88, "cup": 47, "bicycle": 2, "kite": 38, "carrot": 57, "stop sign": 13, "tennis racket": 43, "donut": 60, "snowboard": 36, "sandwich": 54, "motorcycle": 4, "oven": 79, "keyboard": 76, "scissors": 87, "airplane": 5, "couch": 63, "mouse": 74, "fire hydrant": 11, "boat": 9, "apple": 53, "sheep": 20, "horse": 19, "banana": 52, "baseball glove": 40, "tv": 72, "traffic light": 10, "chair": 62, "bowl": 51, "microwave": 78, "bench": 15, "book": 84, "elephant": 22, "orange": 55, "tie": 32, "clock": 85, "bird": 16, "knife": 49, "pizza": 59, "fork": 48, "hair drier": 89, "frisbee": 34, "umbrella": 28, "bottle": 44, "bus": 6, "bear": 23, "vase": 86, "toothbrush": 90, "spoon": 50, "train": 7, "sink": 81, "potted plant": 64, "handbag": 31, "cell phone": 77, "toaster": 80, "broccoli": 56, "refrigerator": 82, "laptop": 73, "remote": 75, "surfboard": 42, "cow": 21, "dining table": 67, "hot dog": 58, "car": 3, "sports ball": 37, "skateboard": 41, "dog": 18, "bed": 65, "cat": 17, "person": 1, "skis": 35, "giraffe": 25, "truck": 8, "parking meter": 14, "suitcase": 33, "cake": 61, "wine glass": 46, "baseball bat": 39, "backpack": 27, "zebra": 24, "url": 91
    ]
    
    static let idToCategory = [
         0: "sentences", 1: "person", 2: "bicycle", 3: "car", 4: "motorcycle", 5: "airplane", 6: "bus", 7: "train", 8: "truck", 9: "boat", 10: "traffic light", 11: "fire hydrant", 13: "stop sign", 14: "parking meter", 15: "bench", 16: "bird", 17: "cat", 18: "dog", 19: "horse", 20: "sheep", 21: "cow", 22: "elephant", 23: "bear", 24: "zebra", 25: "giraffe", 27: "backpack", 28: "umbrella", 31: "handbag", 32: "tie", 33: "suitcase", 34: "frisbee", 35: "skis", 36: "snowboard", 37: "sports ball", 38: "kite", 39: "baseball bat", 40: "baseball glove", 41: "skateboard", 42: "surfboard", 43: "tennis racket", 44: "bottle", 46: "wine glass", 47: "cup", 48: "fork", 49: "knife", 50: "spoon", 51: "bowl", 52: "banana", 53: "apple", 54: "sandwich", 55: "orange", 56: "broccoli", 57: "carrot", 58: "hot dog", 59: "pizza", 60: "donut", 61: "cake", 62: "chair", 63: "couch", 64: "potted plant", 65: "bed", 67: "dining table", 70: "toilet", 72: "tv", 73: "laptop", 74: "mouse", 75: "remote", 76: "keyboard", 77: "cell phone", 78: "microwave", 79: "oven", 80: "toaster", 81: "sink", 82: "refrigerator", 84: "book", 85: "clock", 86: "vase", 87: "scissors", 88: "teddy bear", 89: "hair drier", 90: "toothbrush", 91: "url"
    ]
    
    static let categories = [
        "person", "bicycle", "car", "motorcycle", "airplane", "bus", "train", "truck", "boat", "traffic light", "fire hydrant", "stop sign", "parking meter", "bench", "bird", "cat", "dog", "horse", "sheep", "cow", "elephant", "bear", "zebra", "giraffe", "backpack", "umbrella", "handbag", "tie", "suitcase", "frisbee", "skis", "snowboard", "sports ball", "kite", "baseball bat", "baseball glove", "skateboard", "surfboard", "tennis racket", "bottle", "wine glass", "cup", "fork", "knife", "spoon", "bowl", "banana", "apple", "sandwich", "orange", "broccoli", "carrot", "hot dog", "pizza", "donut", "cake", "chair", "couch", "potted plant", "bed", "dining table", "toilet", "tv", "laptop", "mouse", "remote", "keyboard", "cell phone", "microwave", "oven", "toaster", "sink", "refrigerator", "book", "clock", "vase", "scissors", "teddy bear", "hair drier", "toothbrush"
    ]
    
    static let cocoicons: [String: String] = [
        "person": "https://cocodataset.org/images/cocoicons/1.jpg",
        "bicycle": "https://cocodataset.org/images/cocoicons/2.jpg",
        "car": "https://cocodataset.org/images/cocoicons/3.jpg",
        "motorcycle": "https://cocodataset.org/images/cocoicons/4.jpg",
        "airplane": "https://cocodataset.org/images/cocoicons/5.jpg",
        "bus": "https://cocodataset.org/images/cocoicons/6.jpg",
        "train": "https://cocodataset.org/images/cocoicons/7.jpg",
        "truck": "https://cocodataset.org/images/cocoicons/8.jpg",
        "boat": "https://cocodataset.org/images/cocoicons/9.jpg",
        "traffic light": "https://cocodataset.org/images/cocoicons/10.jpg",
        "fire hydrant": "https://cocodataset.org/images/cocoicons/11.jpg",
        "stop sign": "https://cocodataset.org/images/cocoicons/13.jpg",
        "parking meter": "https://cocodataset.org/images/cocoicons/14.jpg",
        "bench": "https://cocodataset.org/images/cocoicons/15.jpg",
        "bird": "https://cocodataset.org/images/cocoicons/16.jpg",
        "cat": "https://cocodataset.org/images/cocoicons/17.jpg",
        "dog": "https://cocodataset.org/images/cocoicons/18.jpg",
        "horse": "https://cocodataset.org/images/cocoicons/19.jpg",
        "sheep": "https://cocodataset.org/images/cocoicons/20.jpg",
        "cow": "https://cocodataset.org/images/cocoicons/21.jpg",
        "elephant": "https://cocodataset.org/images/cocoicons/22.jpg",
        "bear": "https://cocodataset.org/images/cocoicons/23.jpg",
        "zebra": "https://cocodataset.org/images/cocoicons/24.jpg",
        "giraffe": "https://cocodataset.org/images/cocoicons/25.jpg",
        "backpack": "https://cocodataset.org/images/cocoicons/27.jpg",
        "umbrella": "https://cocodataset.org/images/cocoicons/28.jpg",
        "handbag": "https://cocodataset.org/images/cocoicons/31.jpg",
        "tie": "https://cocodataset.org/images/cocoicons/32.jpg",
        "suitcase": "https://cocodataset.org/images/cocoicons/33.jpg",
        "frisbee": "https://cocodataset.org/images/cocoicons/34.jpg",
        "skis": "https://cocodataset.org/images/cocoicons/35.jpg",
        "snowboard": "https://cocodataset.org/images/cocoicons/36.jpg",
        "sports ball": "https://cocodataset.org/images/cocoicons/37.jpg",
        "kite": "https://cocodataset.org/images/cocoicons/38.jpg",
        "baseball bat": "https://cocodataset.org/images/cocoicons/39.jpg",
        "baseball glove": "https://cocodataset.org/images/cocoicons/40.jpg",
        "skateboard": "https://cocodataset.org/images/cocoicons/41.jpg",
        "surfboard": "https://cocodataset.org/images/cocoicons/42.jpg",
        "tennis racket": "https://cocodataset.org/images/cocoicons/43.jpg",
        "bottle": "https://cocodataset.org/images/cocoicons/44.jpg",
        "wine glass": "https://cocodataset.org/images/cocoicons/46.jpg",
        "cup": "https://cocodataset.org/images/cocoicons/47.jpg",
        "fork": "https://cocodataset.org/images/cocoicons/48.jpg",
        "knife": "https://cocodataset.org/images/cocoicons/49.jpg",
        "spoon": "https://cocodataset.org/images/cocoicons/50.jpg",
        "bowl": "https://cocodataset.org/images/cocoicons/51.jpg",
        "banana": "https://cocodataset.org/images/cocoicons/52.jpg",
        "apple": "https://cocodataset.org/images/cocoicons/53.jpg",
        "sandwich": "https://cocodataset.org/images/cocoicons/54.jpg",
        "orange": "https://cocodataset.org/images/cocoicons/55.jpg",
        "broccoli": "https://cocodataset.org/images/cocoicons/56.jpg",
        "carrot": "https://cocodataset.org/images/cocoicons/57.jpg",
        "hot dog": "https://cocodataset.org/images/cocoicons/58.jpg",
        "pizza": "https://cocodataset.org/images/cocoicons/59.jpg",
        "donut": "https://cocodataset.org/images/cocoicons/60.jpg",
        "cake": "https://cocodataset.org/images/cocoicons/61.jpg",
        "chair": "https://cocodataset.org/images/cocoicons/62.jpg",
        "couch": "https://cocodataset.org/images/cocoicons/63.jpg",
        "potted plant": "https://cocodataset.org/images/cocoicons/64.jpg",
        "bed": "https://cocodataset.org/images/cocoicons/65.jpg",
        "dining table": "https://cocodataset.org/images/cocoicons/67.jpg",
        "toilet": "https://cocodataset.org/images/cocoicons/70.jpg",
        "tv": "https://cocodataset.org/images/cocoicons/72.jpg",
        "laptop": "https://cocodataset.org/images/cocoicons/73.jpg",
        "mouse": "https://cocodataset.org/images/cocoicons/74.jpg",
        "remote": "https://cocodataset.org/images/cocoicons/75.jpg",
        "keyboard": "https://cocodataset.org/images/cocoicons/76.jpg",
        "cell phone": "https://cocodataset.org/images/cocoicons/77.jpg",
        "microwave": "https://cocodataset.org/images/cocoicons/78.jpg",
        "oven": "https://cocodataset.org/images/cocoicons/79.jpg",
        "toaster": "https://cocodataset.org/images/cocoicons/80.jpg",
        "sink": "https://cocodataset.org/images/cocoicons/81.jpg",
        "refrigerator": "https://cocodataset.org/images/cocoicons/82.jpg",
        "book": "https://cocodataset.org/images/cocoicons/84.jpg",
        "clock": "https://cocodataset.org/images/cocoicons/85.jpg",
        "vase": "https://cocodataset.org/images/cocoicons/86.jpg",
        "scissors": "https://cocodataset.org/images/cocoicons/87.jpg",
        "teddy bear": "https://cocodataset.org/images/cocoicons/88.jpg",
        "hair drier": "https://cocodataset.org/images/cocoicons/89.jpg",
        "toothbrush": "https://cocodataset.org/images/cocoicons/90.jpg",
        "sentences": "https://cocodataset.org/images/cocoicons/sentences.jpg",
        "url": "https://cocodataset.org/images/cocoicons/url.jpg"
    ]
}

struct LocalStorageKeys {
    static let categoryIds = "category_ids"
    static let currentPage = "current_page"
}
