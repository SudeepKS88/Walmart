//
//  CollectionViewCell.swift
//  Walmart
//
//  Created by Sudeep Kanikunnel Surendran on 12/6/17.
//  Copyright © 2017 Sudeep Kanikunnel Surendran. All rights reserved.
//

import UIKit

class PagedProductCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: ProductImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var longDescription: UITextView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var ratingCount: UILabel!
    
    // configure the cell using the product details
    func configureCellWithProduct(product: Product) {        
        self.price.text = product.price
        self.productName.text = product.productName
        self.ratingView.rating = product.reviewRating
        self.ratingCount.text = "(\(product.reviewCount))"
        
        if let longDescription = product.longDescription {
            self.longDescription.attributedText = longDescription
        }
        guard let urlString = product.productImage else {
            return
        }
        productImage.loadImage(from: urlString) { (image) in
            self.productImage.image = image
        }
    }
}
