//
//  ContactsReducers.swift
//  Contacts
//
//  Created by Craig Clayton on 1/7/21.
//

import Foundation

func contactsReducer(_ state: ContactsState, _ action: Action) -> ContactsState {
    var state = state
    
    switch action {
        case let action as SetContacts:
            state.contacts = action.contacts
        default:
            break
    }
    
    return state
}
