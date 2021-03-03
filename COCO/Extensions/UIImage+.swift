//
//  UIImage+.swift
//  COCO
//
//  Created by Tuyen Le on 2/27/21.
//

import UIKit

class COCOUIIMageView: UIImageView {
    
    var originalImage: UIImage?
    
    var categorySegmentations: [Int : [[Double]]] = [:]
    
    var categoryColor: [Int : CGColor] = [:]
    
    override var image: UIImage? {
        didSet {
            if originalImage == nil {
                originalImage = image
            }
        }
    }
    
    func removeCategory(id: Int) {
        categorySegmentations.removeValue(forKey: id)
        categoryColor.removeValue(forKey: id)
        
        image = originalImage
        
        for (id, segmentation) in categorySegmentations {
            draw(segmentations: segmentation,
                 color: categoryColor[id] ?? .init(red: 1, green: 1, blue: 1, alpha: 1))
        }
    }
    
    func drawCategory(id: Int, segmentations: [[Double]]) {
        
        // Random color
        let r = CGFloat.random(in: 0...255)
        let g = CGFloat.random(in: 0...255)
        let b = CGFloat.random(in: 0...255)
        let newColor = UIColor(displayP3Red: r / 255, green: g / 255, blue: b / 255, alpha: 1).cgColor
        
        categorySegmentations[id] = segmentations
        categoryColor[id] = newColor

        draw(segmentations: segmentations, color: newColor)
    }
    
    private func draw(segmentations: [[Double]], color: CGColor) {
        guard let image = self.image else { return }
        
        // Create a context of the starting image size and set it as the current one
        UIGraphicsBeginImageContext(image.size)


        // Draw the starting image in the current context as background
        image.draw(at: CGPoint.zero)
        
        // Get the current context
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color)
        context?.setFillColor(gray: 1, alpha: 1)
        context?.setStrokeColor(color)
        context?.setAlpha(1)
        context?.setLineWidth(6)
        
        
        // Draw
        for segmentation in segmentations where segmentation.count % 2 == 0
                                                && CGFloat(segmentation[0]) > 0.0 && CGFloat(segmentation[0]) < image.size.width
                                                && CGFloat(segmentation[1]) > 0.0 && CGFloat(segmentation[1]) < image.size.height
                                                && CGFloat(segmentation[segmentation.endIndex - 2]) > 0.0 && CGFloat(segmentation[segmentation.endIndex - 2]) < image.size.width
                                                && CGFloat(segmentation[segmentation.endIndex - 1]) > 0.0 && CGFloat(segmentation[segmentation.endIndex - 1]) < image.size.height
        
        {
            context?.beginPath()
            
            context?.move(to: CGPoint(x: segmentation[0], y: segmentation[1]))

            for index in stride(from: 0, to: segmentation.endIndex-2, by: 2) {
                let x = segmentation[index + 2]
                let y = segmentation[index + 3]
                context?.addLine(to: CGPoint(x: x, y: y))
                context?.move(to: CGPoint(x: x, y: y))
            }

            context?.addLine(to: CGPoint(x: segmentation[0], y: segmentation[1]))
            context?.closePath()
            context?.drawPath(using: .fillStroke)
        }

        // Save the context as a new UIImage
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.image = newImage
    }
}
