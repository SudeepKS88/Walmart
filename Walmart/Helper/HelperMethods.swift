//
//  HelperMethods.swift
//  Walmart
//
//  Created by Sudeep Kanikunnel Surendran on 12/3/17.
//  Copyright © 2017 Sudeep Kanikunnel Surendran. All rights reserved.
//

import Foundation

extension String {
    func attributedStringFromHTML() -> NSAttributedString? {
        let attrStr = try! NSAttributedString(
            data: (self.data(using: String.Encoding.unicode, allowLossyConversion: true)!),
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil)
        return attrStr
    }
}
