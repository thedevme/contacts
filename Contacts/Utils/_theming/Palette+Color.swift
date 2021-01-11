//
//  Palette+Color.swift
//  Utility
//
//  Created by Craig Clayton on 1/7/21.
//

import SwiftUI
import Foundation

extension Color {
    static let baseBackground = Color("background")
    static let baseText = Color("base-text")
    static let baseRecentText = Color("base-recent-text")
    static let alarmDot = Color("alarm-dot")
    static let capsuleBackground = Color("capsule-background")
    static let contentBackground = Color("content-background")
    static let divider = Color("divider")
    static let iconBackground = Color("icon-background")
    static let blur = Color("blur")
}

extension UIColor {
    static let baseBackground = Color(named: "background")
    static let baseText = Color(named: "base-text")
    static let baseRecentText = Color(named: "base-recent-text")
    static let alarmDot = Color(named: "alarm-dot")
    static let capsuleBackground = Color(named: "capsule-background")
    static let contentBackground = Color(named: "content-background")
    static let divider = Color(named: "divider")
    static let iconBackground = Color(named: "icon-background")
    static let blur = Color(named: "blur")
    
    private static func Color(named key: String) -> UIColor {
       if let color = UIColor(named: key, in: .main, compatibleWith: nil) {
           return color
       }

       return .black
    }
}
