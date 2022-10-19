//
//  TitleSection.swift
//  TestApp
//
//  Created by Andrew Ushakov on 8/31/22.
//

import SwiftUI

struct TitleSection: View {
    let title: String
    let supplement: String

    var body: some View {
        HStack {
            Text(title)
                .font(.custom("MarkPro-Bold", size: 25))
                .padding(.leading, 25)

            Spacer()

            Text(supplement)
                .foregroundColor(Color("Orange"))
                .font(.custom("MarkPro", size: 15))
                .padding(.trailing, 35)
        }
    }
}
