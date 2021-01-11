//
//  SearchView.swift
//  Contacts
//
//  Created by Craig Clayton on 1/7/21.
//

import SwiftUI

struct SearchView: View {
    let props: Props
    @Binding var searchText: String
    @Binding var showCancelButton: Bool
    @Binding var hasSearched: Bool
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    HStack{
                        Image(systemName: "magnifyingglass")
                        
                        TextField("Find contact", text: $searchText, onEditingChanged: { isEditing in
                            self.showCancelButton = true
                        }, onCommit: {
                            props.onSearch(searchText)
                            hasSearched = true
                        })
                        .foregroundColor(.primary)
                        .custom(font: .medium, size: 18)
                        
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                        }
                    }.padding(EdgeInsets(top: 8, leading: 6, bottom: 2, trailing: 6))
                    
                    if showCancelButton  {
                        Button("Cancel") {
                            UIApplication.shared.endEditing(true)
                            self.searchText = ""
                            self.showCancelButton = false
                        }
                        .foregroundColor(Color(.systemBlue))
                        .offset(y: 3)
                    }
                }
                
                Rectangle().fill(Color.divider)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 1)
            }
        }
        .padding(.horizontal)
        .navigationBarHidden(showCancelButton)
    }
}
