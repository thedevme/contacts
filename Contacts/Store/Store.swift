//
//  Store.swift
//  Contacts
//
//  Created by Craig Clayton on 1/7/21.
//

import Foundation

typealias Dispatcher = (Action) -> Void

typealias Reducer<State: ReduxState> = (_ state: State, _ action: Action) -> State
typealias Middleware<StoreState: ReduxState> = (StoreState, Action, @escaping Dispatcher) -> Void

protocol ReduxState {}

struct AppState: ReduxState {
    var contactState = ContactsState()
    var setContactState = SetContactsState()
}

struct ContactsState: ReduxState {
    var contacts = [Contact]()
}

struct SetContactsState: ReduxState {
    var contacts = [Contact]()
}

protocol Action {}

struct SearchContacts: Action {
    let search: String
}

struct FetchContacts: Action {
    let sortType: Constants.SortType
}

struct SetContacts: Action {
    let contacts: [Contact]
    let error: API.Error?
}

class Store<StoreState: ReduxState>: ObservableObject {
    var reducer: Reducer<StoreState>
    @Published var state: StoreState
    @Published var isLoading: Bool = false
    @Published var isSearching: Bool = false
    var middlewares: [Middleware<StoreState>]
    
    init(reducer: @escaping Reducer<StoreState>, state: StoreState,
         middlewares: [Middleware<StoreState>] = []) {
        self.reducer = reducer
        self.state = state
        self.middlewares = middlewares
    }
    
    func dispatch(action: Action) {
        
        if action is FetchContacts || action is SearchContacts {
            isLoading = true
        }
        
        if action is SetContacts {
            isLoading = false
        }
        
        DispatchQueue.main.async {
            self.state = self.reducer(self.state, action)
        }
        
        middlewares.forEach { middleware in
            middleware(state, action, dispatch)
        }
    }
}
