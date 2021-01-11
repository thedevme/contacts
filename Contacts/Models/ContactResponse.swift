//
//  ContactResponse.swift
//  Contacts
//
//  Created by Craig Clayton on 1/7/21.
//

import Foundation
import SwiftUI

struct ContactResponse: Decodable {
    let contacts: [Contact]
    
    private enum CodingKeys: String, CodingKey {
        case contacts = "contacts"
    }
}
