//
//  RatingView.swift
//  Walmart
//
//  Created by Sudeep Kanikunnel Surendran on 12/3/17.
//  Copyright © 2017 Sudeep Kanikunnel Surendran. All rights reserved.
//

import UIKit

open class RatingView: UIView {
    
    private var emptyImageViews: [UIImageView] = []
    private var fullImageViews: [UIImageView] = []
    let maxRating: Int = 5;

    var rating: Float = 0.0 {
        didSet {
            if rating != oldValue {
                refresh()
            }
        }
    }
    var starSize: Int = 15 {
        didSet {
            refresh()
        }
    }
    
    required override public init(frame: CGRect) {
        super.init(frame: frame)
        initImageViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initImageViews()
    }

    private func initImageViews() {
        guard emptyImageViews.isEmpty && fullImageViews.isEmpty else {
            return
        }
        
        for i in 0..<maxRating {
            let imageFrame = CGRect(x: i == 0 ? 0 : i * (5 + starSize), y: 0, width: starSize, height: starSize)
            let emptyImageView = UIImageView()
            emptyImageView.contentMode = UIViewContentMode.scaleAspectFit
            emptyImageView.image = #imageLiteral(resourceName: "StarEmpty")
            emptyImageView.frame = imageFrame
            emptyImageViews.append(emptyImageView)
            addSubview(emptyImageView)
            
            let fullImageView = UIImageView()
            fullImageView.contentMode = UIViewContentMode.scaleAspectFit
            fullImageView.image = #imageLiteral(resourceName: "StarFull")
            fullImageView.frame = imageFrame
            fullImageViews.append(fullImageView)
            addSubview(fullImageView)
        }
    }
    
    // to refresh the view with the rating and masking others
    private func refresh() {
        for i in 0..<fullImageViews.count {
            let imageView = fullImageViews[i]
            
            if rating >= Float(i+1) {
                imageView.layer.mask = nil
                imageView.isHidden = false
            } else if rating > Float(i) && rating < Float(i+1) {
                // Set mask layer for full image
                let maskLayer = CALayer()
                maskLayer.frame = CGRect(x: 0, y: 0, width: CGFloat(rating-Float(i))*imageView.frame.size.width, height: imageView.frame.size.height)
                imageView.layer.mask = maskLayer
                imageView.isHidden = false
            } else {
                imageView.layer.mask = nil;
                imageView.isHidden = true
            }
        }
    }
}
