//
//  JSONParsing.swift
//  Walmart
//
//  Created by Sudeep Kanikunnel Surendran on 12/3/17.
//  Copyright © 2017 Sudeep Kanikunnel Surendran. All rights reserved.
//

import Foundation

protocol Parser {
    func parse<T>(_ data: Data) throws -> [T]
}

protocol JSONDecodable {
    init(_ decoder: JSONDecoder) throws
}

typealias JSONObject = [String: Any]

enum JSONParsingError: Error
{
    case missingKey(key: String)
    case typeMismatch(key: String)
}

class JSONDecoder
{
    let jsonObject: JSONObject
    init(_ jsonObject: JSONObject)
    {
        self.jsonObject = jsonObject
    }
    
    func value<T>(forKey key: String) throws -> T
    {
        guard let value = jsonObject[key] else {
            throw JSONParsingError.missingKey(key: key)
        }
        guard let finalValue = value as? T else {
            throw JSONParsingError.typeMismatch(key: key)
        }
        return finalValue
    }
    
    func value(forKey key: String) throws -> NSAttributedString
    {
        let attributedValue: String = try value(forKey: key)
        return attributedValue.attributedStringFromHTML()!
    }
}

func decode<T>(_ jsonObject: JSONObject) throws -> T where T: JSONDecodable
{
    return try T.init(JSONDecoder(jsonObject))
}
