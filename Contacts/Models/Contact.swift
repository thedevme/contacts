//
//  Contact.swift
//  Contacts
//
//  Created by Craig Clayton on 1/7/21.
//

import Foundation
import SwiftUI

struct Contact: Decodable, Identifiable {
    var id = UUID().uuidString
    let email: String
    let firstName: String
    let lastName: String
    let phone: String
    
    static let `default` = Self(email: "craig@designtoswiftui.io", firstName: "Craig", lastName: "Clayton", phone: "954.643.7750")
    static let noNameDefault = Self(email: "craig@designtoswiftui.io", firstName: "", lastName: "", phone: "954.643.7750")
    
    func showName() -> Bool {
        if firstName.isEmpty && lastName.isEmpty { return false }
        else { return true }
    }
}


let recentContacts:[Contact] = [
    Contact.default,
    Contact.default,
    Contact.default,
    Contact.default,
    Contact.default
]
