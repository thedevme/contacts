//
//  UIApplication+Extensions.swift
//  Contacts
//
//  Created by Craig Clayton on 1/7/21.
//

import SwiftUI
import Combine

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}
