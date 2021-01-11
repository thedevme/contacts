//
//  CapsuleView.swift
//  Contacts
//
//  Created by Craig Clayton on 1/9/21.
//

import SwiftUI

struct CapsuleView: View {
    var body: some View {
        HStack {
            Image("icon-sort")
            
            HStack(spacing: 0) {
                Text("SORT").custom(font: .bold, size: 11)
                Text("DESC").custom(font: .regular, size: 11)
            }.foregroundColor(.white)
        }
        .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
        .background(Color.capsuleBackground)
        .clipShape(Capsule())
    }
}

struct CapsuleView_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleView()
    }
}


struct SortToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 5) {
            Image(configuration.isOn ? "icon-asc" : "icon-desc")
                .resizable()
                .frame(width: 18, height: 17)
            
            HStack(spacing: 0) {
                Text("SORT").custom(font: .bold, size: 14)
                Text(configuration.isOn ? "ASC" : "DESC").custom(font: .regular, size: 14)
            }.foregroundColor(.white)
        }
        .padding(EdgeInsets(top:5, leading: 10, bottom: 5, trailing: 10))
        .background(Color.capsuleBackground)
        .clipShape(Capsule())
    }
}
