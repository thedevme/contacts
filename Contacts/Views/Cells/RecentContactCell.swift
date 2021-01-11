//
//  RecentContactCell.swift
//  Contacts
//
//  Created by Craig Clayton on 1/9/21.
//

import SwiftUI

struct RecentContactCell: View {
    let contact: Contact
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(height: 110)
                .shadow(color: .blur, radius: 6, x: 0, y: 0)
            
            VStack(alignment: .leading, spacing: 5) {
                Image("sample-image")
                    .resizable()
                    .overlay(Circle()
                        .stroke(Color.white, lineWidth: 4))
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    HStack(spacing: 0) {
                        Text(contact.firstName.uppercased()).custom(font: .bold, size: 18)
                        Text(contact.lastName.uppercased()).custom(font: .ultralight, size: 18)
                    }
                    .opacity(contact.showName() ? 1 : 0)
                    
                    Text(contact.email)
                        .custom(font: .courier, size: 12)
                        .opacity(contact.showName() ? 0 : 1)
                        .frame(height: contact.showName() ? 0 : 15)
                    
                }.foregroundColor(.baseRecentText)
                
                HStack {
                    HStack(alignment: .bottom) {
                        HStack {
                            Image(systemName: "deskclock").font(.system(size: 12))
                        }
                        .padding(5)
                        .background(Color.iconBackground)
                        .cornerRadius(4)
                        .foregroundColor(.white)
                        
                        HStack(alignment: .bottom, spacing: 4) {
                            Text("2")
                            HStack(spacing: 0) {
                                Text("HRS").custom(font: .bold, size: 10)
                                Text("AG0").custom(font: .regular, size: 10)
                            }
                        }.foregroundColor(.baseRecentText)
                    }
                }
            }
            .padding()
            .offset(y: -25)
            .frame(height: 110)
        }
        
    }
}

struct RecentContactCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ZStack {
                Color.baseBackground.edgesIgnoringSafeArea(.all)
                RecentContactCell(contact: Contact.default)
            }
            ZStack {
                Color.baseBackground.edgesIgnoringSafeArea(.all)
                RecentContactCell(contact: Contact.noNameDefault)
            }
        }
    }
}
