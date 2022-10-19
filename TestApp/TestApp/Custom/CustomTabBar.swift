//
//  CustomTabView.swift
//  TestApp
//
//  Created by Andrew Ushakov on 8/26/22.
//

import SwiftUI

struct CustomTabBar: View {
    @State private var cart = Cart.example

    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Explorer")
                    .font(.custom("MarkPro-Bold", size: 15))

                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(.white)
                    .offset(x: 5)
            }.padding(.leading, 30)

            NavigationLink {
                CartView()
            } label: {
                ZStack {
                    Image(systemName: "bag")
                        .font(.title3)
                        .padding(.horizontal, 35)

                    if !cart.basket.isEmpty {
                        Text("\(cart.basket.count)")
                            .bold()
                            .foregroundColor(.white)
                            .font(.callout)
                            .padding(.top, 45)
                    }
                }
            }
            .padding(.leading, 10)

            NavigationLink {
                Text("Heart")
            } label: {
                Image(systemName: "heart")
                    .font(.title3)
                    .padding(.horizontal, 35)
            }

            NavigationLink {
                Text("Profile")
            } label: {
                Image(systemName: "person")
                    .font(.title3)
                    .padding(.horizontal, 35)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 90)
        .foregroundColor(.white)
        .background(Color("Blue"))
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .task {
            do {
                let url = URL(string: "https://run.mocky.io/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149")!
                let (data, _) = try await URLSession.shared.data(from: url)
                cart = try JSONDecoder().decode(Cart.self, from: data)
            } catch {
                cart = Cart.example
            }
        }
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar()
    }
}
