//
//  ProductImageView.swift
//  Walmart
//
//  Created by Sudeep Kanikunnel Surendran on 12/3/17.
//  Copyright © 2017 Sudeep Kanikunnel Surendran. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSURL, UIImage>()

class ProductImageView: UIImageView {
    var imageUrlString: String?
    
    func loadImage(from urlString: String, completion: @escaping (UIImage) -> Void) {
        imageUrlString = urlString
        
        guard let imageUrl = URL(string: urlString) else { return }
        if let image = imageCache.object(forKey: imageUrl as NSURL) {
            completion(image)
        } else {
            NetworkService.imageDataTask(with: urlString) { (imageData) in
                guard let imageData = imageData,
                    let image = UIImage(data: imageData)
                    else { return }
                DispatchQueue.main.async {
                    // check if the image is for the same imageview
                    if (self.imageUrlString == urlString) {
                        completion(image)
                    }
                    imageCache.setObject(image, forKey: imageUrl as NSURL)
                }
            }
        }
    }
}
