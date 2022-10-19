//
//  CartView.swift
//  TestApp
//
//  Created by Andrew Ushakov on 8/30/22.
//

import SwiftUI

struct CartView: View {
    @State private var cart = Cart.example

    @Environment(\.dismiss) var dismiss

    var screenSize: ScreenSize {
        if UIScreen.main.bounds.width > 414 {
            return .big
        } else if UIScreen.main.bounds.width == 414 {
            return .medium
        } else {
            return .small
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.black).opacity(0.05).ignoresSafeArea()

                VStack {
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 37, height: 37)
                                .foregroundColor(Color("Blue"))

                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.title3)
                        }
                        .padding(.trailing, 95)
                        .onTapGesture {
                            dismiss()
                        }

                        Text("Add address")
                            .font(.custom("MarkPro-Medium", size: 15))
                            .padding(.leading, 65)

                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color("Orange"))
                                .frame(width: 37, height: 37)

                            Image(systemName: "mappin")
                                .foregroundColor(.white)
                                .font(.title3)
                        }
                    }
                    .offset(x: screenSize == .small ? -20 : 0, y: 20)

                    Text("My Cart")
                        .font(.custom("MarkPro-Bold", size: 35))
                        .padding(.trailing, 190)
                        .offset(y: 35)

                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color("Blue"))
                            .frame(width: 430, height: 700)

                        VStack {
                            VStack {
                                ForEach(cart.basket) { item in
                                    HStack {
                                        AsyncImage(url: URL(string: item.images)) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 88, height: 88)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                        } placeholder: {
                                            ProgressView()
                                        }

                                        VStack(alignment: .leading, spacing: 20) {
                                            Text(item.title)
                                                .font(.custom("MarkPro-Medium", size: 20))
                                                .foregroundColor(.white)

                                            Text("$\(item.price)")
                                                .font(.custom("MarkPro-Medium", size: 20))
                                                .foregroundColor(Color("Orange"))
                                        }.padding(.leading, 10)

                                        Spacer()

                                        ZStack {
                                            RoundedRectangle(cornerRadius: 26)
                                                .foregroundColor(Color.init(hex: "282843"))
                                                .frame(width: 26, height: 68)

                                            VStack(spacing: 5) {
                                                Image(systemName: "minus")
                                                    .resizable()
                                                    .bold()
                                                    .foregroundColor(.white)
                                                    .frame(width: 9, height: 2)

                                                Text("1")
                                                    .foregroundColor(.white)
                                                    .font(.custom("MarkPro-Medium", size: 20))

                                                Image(systemName: "plus")
                                                    .resizable()
                                                    .bold()
                                                    .foregroundColor(.white)
                                                    .frame(width: 8.36, height: 9)
                                            }
                                        }

                                        Image(systemName: "trash")
                                            .resizable()
                                            .bold()
                                            .foregroundColor(Color.init(hex: "36364D"))
                                            .frame(width: 15, height: 16)
                                            .padding(.leading, 15)

                                    }
                                    .padding(.horizontal, 30)
                                    .padding(.trailing, screenSize == .small ? 20 : 0)
                                }.padding(.vertical, 20)
                            }.padding(.top, 50)

                            Spacer()

                            VStack {
                                Divider().background(Color.init(hex: "FFFFFF"))

                                HStack {
                                    Text("Total")
                                        .font(.custom("MarkPro", size: 15))
                                        .padding(.leading, 40)

                                    Spacer()

                                    Text("$\(cart.total) us")
                                        .font(.custom("MarkPro-Bold", size: 15))
                                        .padding(.trailing, 40)
                                }
                                .foregroundColor(.white)
                                .padding(.top, 10)
                                .padding(.trailing, screenSize == .small ? 20 : 0)

                                HStack {
                                    Text("Delivery")
                                        .font(.custom("MarkPro", size: 15))
                                        .padding(.leading, 40)

                                    Spacer()

                                    Text(cart.delivery)
                                        .font(.custom("MarkPro-Bold", size: 15))
                                        .padding(.trailing, 40)
                                }
                                .foregroundColor(.white)
                                .padding(.top, 2)
                                .padding(.bottom, 10)
                                .padding(.trailing, screenSize == .small ? 20 : 0)

                                Divider().background(Color.init(hex: "FFFFFF"))

                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color("Orange"))
                                        .frame(width: 326, height: 54)

                                    Text("Checkout")
                                        .foregroundColor(.white)
                                        .font(.custom("MarkPro-Bold", size: 20))
                                }
                                .padding(.top, 20)
                                .padding(.trailing, screenSize == .small ? 25 : 10)
                            }.padding(.bottom, 80)
                        }
                    }.offset(y: geometry.size.height / 19)
                }
            }
        }
        .navigationBarBackButtonHidden()
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

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
