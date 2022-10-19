//
//  CustomTextField.swift
//  TestApp
//
//  Created by Andrew Ushakov on 8/24/22.
//

import SwiftUI

struct CustomTextField: View {
    var textField: TextField<Text>

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 13.5, height: 13.5)
                .foregroundColor(Color("Orange"))
                .padding(.leading, 5)
                .padding(.trailing, 10)

            textField
                .font(.custom("MarkPro", size: 12))
        }
        .padding()
        .background(Color.white)
        .frame(width: 300, height: 34)
        .clipShape(Capsule())
        .shadow(color: .black.opacity(0.15), radius: 4)
    }
}
