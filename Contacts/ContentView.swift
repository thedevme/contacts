//
//  ContentView.swift
//  Contacts
//
//  Created by Craig Clayton on 1/7/21.
//

import SwiftUI

struct Props {
    let contacts: [Contact]
    let onSearch: (String) -> Void
    let onFetchContacts: (_ sort: Constants.SortType) -> Void
}

struct ContentView: View {
    
    @EnvironmentObject var store: Store<AppState>
    
    @State private var isAscending = false
    @State private var searchText: String = ""
    @State private var showCancelButton: Bool = false
    @State private var hasSearched: Bool = false
    
    @State private var sort: Constants.SortType = .desc
    
    var body: some View {
        let props = map(state: store.state.contactState)
        
        ZStack {
            Color(.baseBackground).edgesIgnoringSafeArea(.all)
            
            VStack {
                header
                recentlyViewed
                
                VStack {
                    
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: 0) {
                            Text("YOUR").custom(font: .bold, size: 24)
                            Text("CONTACTS").custom(font: .ultralight, size: 24)
                        }
                        .padding(.leading)
                        .padding(.vertical, 10)
                        
                        VStack(spacing: 0) {
                            SearchView(props: props, searchText: $searchText, showCancelButton: $showCancelButton, hasSearched: $hasSearched)
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    Button(action: { sortContacts(props: props) }) {
                                        Toggle("Selected", isOn: $isAscending)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .toggleStyle(SortToggleStyle())
                                    
                                    
                                }.padding(.leading)
                                
                            }.padding(.vertical)
                        }
                    }

                    ZStack {
                        ScrollView {
                            VStack {
                                ForEach(props.contacts) { contact in
                                    ContactCell(contact: contact)
                                }
                            }
                        }
                        
                        if hasSearched && props.contacts.count == 0 {
                            Text("No results found!")
                        }
                        
                        VStack {
                            Text("Loading").custom(font: .regular, size: 24)
                            ProgressView()
                                .scaleEffect(1.5, anchor: .center)
                                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                .foregroundColor(.blue)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .background(Color.white)
                        .opacity(store.isLoading ? 1 : 0)
                    }
                }
                .background(Color.contentBackground)
                .cornerRadius(10)
                .padding(.horizontal, 10)
            }
        }
        .onAppear(perform: {
            fetchContacts(props: props)
        })
    }
    
    func fetchContacts(props: Props) {
        props.onFetchContacts(sort)
    }
    
    func sortContacts(props: Props) {
        isAscending.toggle()
        
        if isAscending {
            sort = .asc
        } else {
            sort = .desc
        }
        
        props.onFetchContacts(sort)
    }
    
    var header: some View {
        HStack(alignment: .top) {
            Image("sample-image")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: -5) {
                Text("WELCOME").custom(font: .bold, size: 12)
                
                HStack(spacing: 0) {
                    Text("ARYA").custom(font: .bold, size: 24)
                    Text("STARK").custom(font: .ultralight, size: 24)
                }
            }
            
            Spacer()
            
            Image(systemName: "bell.badge.fill")
                .foregroundColor(Color.baseText)
        }
        .padding(.horizontal, 10)
        .padding(.vertical)
    }
    
    var recentlyViewed: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text("RECENTLY").custom(font: .bold, size: 24)
                Text("VIEWED").custom(font: .ultralight, size: 24)
            }
            .padding(.leading)
            .padding(.top, 20)
            .padding(.bottom, 5)
            
            ScrollView(.horizontal) {
                HStack(spacing: 15){
                    ForEach(recentContacts) { contact in
                        RecentContactCell(contact: contact)
                            .frame(width: 150, height: 165)
                            
                    }
                }.padding(.leading, 10)
            }
        }
        .frame(height: 200)
        .background(Color.contentBackground)
        .cornerRadius(10)
        .padding(.horizontal, 10)
    }
}

private extension ContentView {
    func map(state: ContactsState) -> Props {
        Props(contacts: state.contacts, onSearch: { keyword in
            store.dispatch(action: SearchContacts(search: keyword))
        }, onFetchContacts: { (sort) in
            store.dispatch(action: FetchContacts(sortType: sort))
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(reducer: appReducer,
                          state: AppState(),
                          middlewares: [contactsMiddleware()])
        
        return ContentView().environmentObject(store)
    }
}


