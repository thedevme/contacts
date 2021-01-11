//
//  ContactsMiddleware.swift
//  Contacts
//
//  Created by Craig Clayton on 1/7/21.
//

import Foundation
import Combine

func contactsMiddleware() -> Middleware<AppState> {
    let api = API()
    var subscriptions = Set<AnyCancellable>()
    
    return { state, action, dispatch in
        switch action {
        case let action as SearchContacts:
            
            api.search(action.search.urlEncode())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    if case .failure(let err) = completion {
                        dispatch(SetContacts(contacts: [], error: err))
                    }
                }, receiveValue: { response in
                    dispatch(SetContacts(contacts: response.contacts, error: nil))
                }).store(in: &subscriptions)
            
        case let action as FetchContacts:
            
            api.fetchContacts(sort: action.sortType)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    if case .failure(let err) = completion {
                        dispatch(SetContacts(contacts: [], error: err))
                    }
                }, receiveValue: { response in
                    dispatch(SetContacts(contacts: response.contacts, error: nil))
                }).store(in: &subscriptions)
            
        default:
            return
        }
    }
}
