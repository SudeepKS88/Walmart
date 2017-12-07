//
//  ProductListPresenter.swift
//  Walmart
//
//  Created by Sudeep Kanikunnel Surendran on 12/2/17.
//  Copyright © 2017 Sudeep Kanikunnel Surendran. All rights reserved.
//

import Foundation

typealias ProductsFetchedClosure = (PagedProductDetail<Product>?) -> Void

class ProductListPresenter {
    private let session: URLSession = .shared;
    
    func loadProducts(page pageNumber: Int = 0, resultsPerPage: Int = 10, resultsLoaded: @escaping ProductsFetchedClosure) {
        let urlString = "\(productList)\(pageNumber)/\(resultsPerPage)"
        NetworkService.dataTask(with: urlString) { (data) in
            guard let data = data else { return }
            do {
                let products: [Product] = try self.parse(data)
                let productsFetchDetails = PagedProductDetail(products: products, pageNumber: pageNumber)
                resultsLoaded(productsFetchDetails)
                
            } catch let jsonError {
                print("Error", jsonError)
            }
        }
    }
}

extension ProductListPresenter: Parser {
    func parse<T>(_ data: Data) throws -> [T] {
        return try parse(data)
    }
    
    func parse(_ data: Data) throws -> [Product]
    {
        let json: JSONObject = try JSONSerialization.jsonObject(with: data, options: []) as! JSONObject
        guard let productJsonObjects = json["products"] else { return []}
        
        let products: [Product] = try (productJsonObjects as! Array).map(decode)
        return products
    }
}
