//
//  ProductTableViewCell.swift
//  Walmart
//
//  Created by Sudeep Kanikunnel Surendran on 12/2/17.
//  Copyright © 2017 Sudeep Kanikunnel Surendran. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var productImage: ProductImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var ratingCount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        ratingView.backgroundColor = UIColor.clear
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        price.text = nil
        productImage.image = nil
        productName.text = nil
    }
    
    func configureCell(withProduct product: Product) {
        price.text = product.price
        productName.text = product.productName
        ratingView.rating = product.reviewRating
        ratingCount.text = "(\(product.reviewCount))"
        guard let urlString = product.productImage else {
            return
        }
        productImage.loadImage(from: urlString) { (image) in
            self.productImage.image = image
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
