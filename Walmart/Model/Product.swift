//
//  Product.swift
//  Walmart
//
//  Created by Sudeep Kanikunnel Surendran on 12/2/17.
//  Copyright © 2017 Sudeep Kanikunnel Surendran. All rights reserved.
//

import UIKit

struct PagedProductDetail<Product>
{
    var products: [Product]
    var pageNumber: Int
}

struct Product: JSONDecodable {
    var productId : String
    var productName : String
    var shortDescription : NSAttributedString?
    var longDescription : NSAttributedString?
    var price : String
    var productImage : String?
    var reviewRating : Float
    var reviewCount : Int
    var inStock : Bool
    
    init(_ decoder: JSONDecoder) throws {
        self.productId = try decoder.value(forKey: "productId")
        self.productName = try decoder.value(forKey: "productName")
        self.shortDescription = try? decoder.value(forKey: "shortDescription")
        self.longDescription = try? decoder.value(forKey: "longDescription")
        self.price = try decoder.value(forKey: "price")
        self.productImage = try decoder.value(forKey: "productImage")
        self.reviewRating = try decoder.value(forKey: "reviewRating")
        self.reviewCount = try decoder.value(forKey: "reviewCount")
        self.inStock = try decoder.value(forKey: "inStock")
    }
}
