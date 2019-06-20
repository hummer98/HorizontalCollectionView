//
//  UIImage+generate.swift
//  HorizontalCollectionView_Example
//
//  Created by kdg-developer on 2019/06/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit


extension UIImage {
    
    static func box(size: CGSize, color: UIColor = .white) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        
        defer {
            UIGraphicsEndImageContext()
        }
        
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        
        guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            return self.init()
        }
        return self.init(cgImage: aCgImage)
    }
    
    
}
