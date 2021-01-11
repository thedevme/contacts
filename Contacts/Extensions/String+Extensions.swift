//
//  String+Extensions.swift
//  Contacts
//
//  Created by Craig Clayton on 1/7/21.
//

import Foundation

extension String {
    func urlEncode() -> String {
        self.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? self
    }
}
