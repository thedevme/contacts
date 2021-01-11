//
//  ContactsApp.swift
//  Contacts
//
//  Created by Craig Clayton on 1/7/21.
//

import SwiftUI

@main
struct ContactsApp: App {
    var body: some Scene {
        let store = Store(reducer: appReducer, state: AppState(), middlewares: [contactsMiddleware()])
        
        
        
        
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
