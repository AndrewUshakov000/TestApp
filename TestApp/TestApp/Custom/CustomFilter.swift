//
//  CustomFilterView.swift
//  TestApp
//
//  Created by Andrew Ushakov on 8/26/22.
//

import SwiftUI

struct CustomFilter: View {
    @State private var brandSelection = "Samsung"
    @State private var priceSelection = "$300 - $500"
    @State private var sizeSelection = "4.5 to 5.5 inches"

    @Environment(\.dismiss) var dismiss

    let brands = ["Samsung", "Apple", "Xiaomi"]
    let prices = ["$100 - $300", "$300 - $500", "$500 - $1000", "$1000 - $2000", "$2000 - $5000", "$5000 - $10000"]
    let sizes = ["4.5 to 5.5 inches", "5.5 to 6.5 inches", "6.5 to 7 inches"]

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.white.edgesIgnoringSafeArea(.bottom)

            VStack {
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 37, height: 37)
                            .foregroundColor(Color("Blue"))

                        Image("Cross")
                            .resizable()
                            .frame(width: 11, height: 10)
                    }
                    .padding(.leading, 40)
                    .onTapGesture {
                        dismiss()
                    }

                    Spacer()

                    Text("Filter options")
                        .font(.custom("MarkPro-Medium", size: 18))
                        .offset(x: 20)

                    Spacer()

                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color("Orange"))
                            .frame(width: 86, height: 37)

                        Text("Done")
                            .font(.custom("MarkPro-Medium", size: 18))
                            .foregroundColor(.white)
                    }
                    .padding(.trailing)
                    .onTapGesture {
                        dismiss()
                    }
                }.padding(.top)

                VStack(alignment: .leading) {
                    Text("Brand")
                        .font(.custom("MarkPro-Medium", size: 18))
                        .padding(.leading, 45)
                        .padding(.vertical, 10)

                    Menu {
                        Picker(selection: $brandSelection, label: EmptyView()) {
                            ForEach(brands, id: \.self) { brand in
                                Text(brand)
                            }
                        }
                    } label: {
                        HStack {
                            Text(brandSelection)
                                .font(.custom("MarkPro", size: 18))
                                .foregroundColor(.black)
                                .padding(.leading, 65)

                            Spacer()

                            Image("Chevron")
                                .resizable()
                                .frame(width: 16, height: 8)
                                .padding(.trailing, 70)
                        }.overlay(
                            RoundedRectangle(cornerRadius: 5).stroke(Color.secondary, lineWidth: 1)
                                .frame(width: 337, height: 37)
                        )
                    }

                    Text("Price")
                        .font(.custom("MarkPro-Medium", size: 18))
                        .padding(.leading, 50)
                        .padding(.vertical, 10)

                    Menu {
                        Picker(selection: $priceSelection, label: EmptyView()) {
                            ForEach(prices, id: \.self) { price in
                                Text(price)
                            }
                        }
                    } label: {
                        HStack {
                            Text(priceSelection)
                                .font(.custom("MarkPro", size: 18))
                                .foregroundColor(.black)
                                .padding(.leading, 65)

                            Spacer()

                            Image("Chevron")
                                .resizable()
                                .frame(width: 16, height: 8)
                                .padding(.trailing, 70)
                        }.overlay(
                            RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1)
                                .frame(width: 337, height: 37)
                        )
                    }

                    Text("Size")
                        .font(.custom("MarkPro-Medium", size: 18))
                        .padding(.leading, 50)
                        .padding(.vertical, 10)

                    Menu {
                        Picker(selection: $sizeSelection, label: EmptyView()) {
                            ForEach(sizes, id: \.self) { size in
                                Text(size)
                            }
                        }
                    } label: {
                        HStack {
                            Text(sizeSelection)
                                .font(.custom("MarkPro", size: 18))
                                .foregroundColor(.black)
                                .padding(.leading, 70)

                            Spacer()

                            Image("Chevron")
                                .resizable()
                                .frame(width: 16, height: 8)
                                .padding(.trailing, 65)
                        }.overlay(
                            RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1)
                                .frame(width: 337, height: 37)
                        )
                    }
                }.padding(.top)

                Spacer()
            }
        }
    }
}

struct CustomFilter_Previews: PreviewProvider {
    static var previews: some View {
        CustomFilter()
    }
}
