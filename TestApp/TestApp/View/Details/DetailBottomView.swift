//
//  DetailBottomView.swift
//  TestApp
//
//  Created by Andrew Ushakov on 8/29/22.
//

import SwiftUI

struct DetailBottomView: View {
    @Namespace var animation

    @State private var selectedCategory = "Shop"
    @State private var selectedCapaticy = ""
    @State private var selectedColor = ""

    var details: Details

    let categories = ["Shop", "Details", "Features"]

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
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(.white)
                    .frame(width: geometry.size.width, height: geometry.size.height / 1.8)
                    .shadow(radius: 5)

                VStack(alignment: .leading) {
                    HStack {
                        Text(details.title)
                            .font(.custom("MarkPro-Medium", size: 24))
                            .padding(.leading, 40)

                        Spacer()

                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 37, height: 33)
                                .foregroundColor(Color("Blue"))

                            Image(systemName: "heart")
                                .foregroundColor(.white)
                                .font(.callout)
                        }
                        .padding(.trailing, 35)
                    }.padding(.top, 10)

                    RatingView(rating: Float(details.rating))
                        .padding(.leading, 40)
                        .padding(.bottom, 30)

                    HStack(spacing: 0) {
                        ForEach(categories, id: \.self) { category in
                            ZStack {
                                Text(category)
                                    .foregroundColor(selectedCategory == category ? .black : .gray)
                                    .font(.custom("MarkPro-Bold", size: screenSize == .small ? 18 : 20))
                                    .padding(.leading, screenSize == .small ? 50 : 55)
                                    .onTapGesture {
                                        withAnimation {
                                            selectedCategory = category
                                        }
                                    }

                                if selectedCategory == category {
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundColor(Color("Orange"))
                                        .frame(width: 90, height: 3)
                                        .offset(x: 27.5, y: 20)
                                        .matchedGeometryEffect(id: "Category", in: animation)
                                }
                            }
                        }
                    }

                    HStack {
                        VStack {
                            Image("CPU")
                                .resizable()
                                .frame(width: 28, height: 28)

                            Text(details.CPU)
                                .foregroundColor(.secondary)
                                .font(.custom("MarkPro", size: 11))
                        }.padding(.leading, 25)

                        VStack {
                            Image("Camera")
                                .resizable()
                                .frame(width: 28, height: 22)

                            Text(details.camera)
                                .foregroundColor(.secondary)
                                .font(.custom("MarkPro", size: 11))
                        }.padding(.leading, 33)

                        VStack {
                            Image("SSD")
                                .resizable()
                                .frame(width: 28, height: 21)

                            Text(details.ssd)
                                .foregroundColor(.secondary)
                                .font(.custom("MarkPro", size: 11))
                        }.padding(.leading, 50)

                        VStack {
                            Image("SD")
                                .resizable()
                                .frame(width: 19, height: 22)

                            Text(details.sd)
                                .foregroundColor(.secondary)
                                .font(.custom("MarkPro", size: 11))
                        }.padding(.leading, 50)
                    }
                    .padding(.top, 20)
                    .padding(.leading, screenSize == .small ? 0 : 10)

                    Text("Select color and capacity")
                        .font(.custom("MarkPro-Medium", size: 16))
                        .padding(.leading, 40)
                        .padding(.top)

                    HStack(spacing: 16) {
                        ForEach(details.color, id: \.self) { color in
                            ZStack {
                                Circle()
                                    .foregroundColor(Color.init(hex: color))
                                    .frame(width: 40, height: 40)
                                    .onTapGesture {
                                        withAnimation {
                                            selectedColor = color
                                        }
                                    }

                                if selectedColor == color {
                                    Image(systemName: "checkmark")
                                        .bold()
                                        .foregroundColor(.white)
                                        .frame(width: 17, height: 12.5)
                                }
                            }
                        }

                        HStack {
                            ForEach(details.capacity, id: \.self) { capacity in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(selectedCapaticy == capacity ? Color("Orange") : .clear)
                                        .frame(width: 71, height: 30)

                                    Text("\(capacity) GB")
                                        .foregroundColor(selectedCapaticy == capacity ? .white : .gray)
                                        .font(.custom("MarkPro-Bold", size: 13))
                                }.onTapGesture {
                                    withAnimation {
                                        selectedCapaticy = capacity
                                    }
                                }
                            }
                        }.padding(.leading, 50)
                    }
                    .padding(.leading, 40)
                    .padding(.bottom)

                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: geometry.size.width - 60, height: 54)
                            .foregroundColor(Color("Orange"))

                        HStack {
                            Text("Add to Cart")
                                .foregroundColor(.white)
                                .font(.custom("MarkPro-Bold", size: 20))
                                .padding(.leading, 70)

                            Spacer()

                            Text("$\(details.price)")
                                .foregroundColor(.white)
                                .font(.custom("MarkPro-Bold", size: 20))
                                .padding(.trailing, 60)
                        }
                    }
                    .padding(.leading, 10)
                    .padding(.top, 5)
                }.padding(.bottom)
            }.offset(y: geometry.size.height / 2)
        }
    }
}
