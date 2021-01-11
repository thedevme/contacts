//
//  View+Extensions.swift
//  Contacts
//
//  Created by Craig Clayton on 1/7/21.
//

import Foundation
import SwiftUI

extension View {
    
    func embedInNavigationView() -> some View {
        NavigationView { self }
    }
    
}
