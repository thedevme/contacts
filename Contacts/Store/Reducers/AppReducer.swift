//
//  AppReducer.swift
//  Contacts
//
//  Created by Craig Clayton on 1/7/21.
//

import Foundation

func appReducer(_ state: AppState, _ action: Action) -> AppState {
    var state = state
    state.contactState = contactsReducer(state.contactState, action)
    return state
}
