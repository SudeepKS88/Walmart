//
//  NetworkService.swift
//  Walmart
//
//  Created by Sudeep Kanikunnel Surendran on 12/3/17.
//  Copyright © 2017 Sudeep Kanikunnel Surendran. All rights reserved.
//

import Foundation

let session: URLSession = .shared
let imageSession = URLSession(configuration: .ephemeral)

let apiKey = "170c7f99-81b5-4904-99c6-a9000794f757"
let baseUrlString = "https://walmartlabs-test.appspot.com/_ah/api/walmart/v1"
let productList = "/walmartproducts/\(apiKey)/"

enum HTTPError: Error {
    case invalidResponse
    case invalidStatusCode
    case requestFailed(statusCode: Int, message: String)
}

enum HTTPStatusCode: Int
{
    case success = 200
    case notFound = 404
    
    var isSuccessful: Bool {
        return (200..<300).contains(rawValue)
    }
    
    var message: String {
        return HTTPURLResponse.localizedString(forStatusCode: rawValue)
    }
}

func validate(_ response: URLResponse?) throws
{
    guard let response = response as? HTTPURLResponse else {
        throw HTTPError.invalidResponse
    }
    guard let status = HTTPStatusCode(rawValue: response.statusCode) else {
        throw HTTPError.invalidStatusCode
    }
    if !status.isSuccessful {
        throw HTTPError.requestFailed(statusCode: status.rawValue, message: status.message)
    }
}

class NetworkService {
    class func dataTask(with urlString: String, completionHandler: @escaping (Data?) -> Swift.Void) -> Void {
        if let url = URL(string: "\(baseUrlString)\(urlString)") {
            let task = session.dataTask(with: url) { (data, response, error) in
                do {
                    try validate(response)
                    completionHandler(data)
                }
                catch {
                    print("Error in Service Network Call: \(error)")
                }
            }
            task.resume()
        }
    }
    
    class func imageDataTask(with urlString: String, completionHandler: @escaping (Data?) -> Swift.Void) -> Void {
        if let url = URL(string: urlString) {
            let task = imageSession.dataTask(with: url) { (data, response, error) in
                completionHandler(data)
            }
            task.resume()
        }
    }
}
