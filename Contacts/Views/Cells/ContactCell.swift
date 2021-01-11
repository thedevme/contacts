//
//  ContactCell.swift
//  Contacts
//
//  Created by Craig Clayton on 1/7/21.
//

import SwiftUI

struct ContactCell: View {
    let contact: Contact
    
    var body: some View {
        VStack {
            HStack {
                Image("sample-image")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    
                    HStack(spacing: 0) {
                        Text(contact.firstName.uppercased()).custom(font: .bold, size: 24)
                        Text(contact.lastName.uppercased()).custom(font: .ultralight, size: 24)
                    }
                    .opacity(contact.showName() ? 1 : 0)
                    
                    Text(contact.email)
                        .offset(y: contact.showName() ? 0 : -10)
                        .custom(font: .courier, size: 12)
                }.foregroundColor(.baseText)
                
                Spacer()
                
            }
            
            Rectangle()
                .fill(Color.divider)
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 1)
        }
        .padding(.leading)
    }
}

struct ContactCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContactCell(contact: Contact.default)
            ContactCell(contact: Contact.noNameDefault)
        }
    }
}
