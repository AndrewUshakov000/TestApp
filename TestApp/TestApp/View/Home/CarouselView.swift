//
//  CarouselView.swift
//  TestApp
//
//  Created by Andrew Ushakov on 9/2/22.
//

import SwiftUI



struct CarouselView: View {
    var trade: Trade
    var screenSize: ScreenSize

    let screen = UIScreen.main.bounds.width

    @State private var offsetX: CGFloat = 0
    @State private var count = 0

    // Adjust the offset of our carousel for different iPhones
    var geometryOffset: CGFloat {
        switch screenSize {
        case .big:
            return  -screen + 57
        case .medium:
            return -screen + 60
        case .small:
            return  -screen + 50
        }
    }

    var body: some View {
        GeometryReader { geometry in
            let geometryWidth = geometry.size.width

            HStack(spacing: 30) {
                ForEach(trade.home_store) { item in
                    ZStack(alignment: .leading) {
                        AsyncImage(url: URL(string: item.picture), content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometryWidth - 60, height: 182)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(RoundedRectangle(cornerRadius: 10).opacity(0.5))
                        }, placeholder: {
                            ProgressView()
                        })

                        VStack(alignment: .leading) {
                            if item.is_new != nil {
                                ZStack {
                                    Circle()
                                        .foregroundColor(Color("Orange"))
                                        .frame(width: 27, height: 27)

                                    Text("New")
                                        .bold()
                                        .font(.system(size: 10))
                                        .foregroundColor(.white)
                                }.padding(.bottom, 5)
                            }

                            Text(item.title)
                                .font(.custom("SFProDisplay-Bold", size: 25))
                                .foregroundColor(.white)
                                .padding(.bottom, 1)

                            Text(item.subtitle)
                                .font(.custom("SFProDisplay-Regular", size: 11))
                                .foregroundColor(.white)
                                .padding(.bottom, 20)

                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(.white)
                                    .frame(width: 98, height: 23)

                                NavigationLink {
                                    DetailView()
                                } label: {
                                    Text("Buy now!")
                                        .foregroundColor(.black)
                                        .bold()
                                        .font(.system(size: 11))
                                }
                            }
                        }
                        .padding(.leading, 20)
                        .padding(.top, item.is_new != nil ? 0 : 35)
                    }
                    .offset(x: self.offsetX)
                    .highPriorityGesture(
                        DragGesture()
                            .onChanged({ value in
                                let valueWidth = value.translation.width

                                withAnimation {
                                    if valueWidth > 0 {
                                        self.offsetX = value.location.x
                                    } else {
                                        self.offsetX = value.location.x - geometryWidth
                                    }
                                }
                            })
                            .onEnded({ value in
                                let valueWidth = value.translation.width
                                let geometryScreen = (geometryWidth - 80) / 2
                                let halfOfStoreItems = trade.home_store.count / 2

                                withAnimation {
                                    if valueWidth > 0 {
                                        if valueWidth > geometryScreen && self.count != halfOfStoreItems {
                                            self.count += 1
                                        }

                                        // Adjust our carousel scrolling for different iPhones
                                        switch screenSize {
                                        case .big:
                                            self.offsetX = (geometryWidth - 30) * CGFloat(count)
                                        case .medium:
                                             self.offsetX = (geometryWidth - 30) * CGFloat(count)
                                        case .small:
                                            self.offsetX = (geometryWidth - 30) * CGFloat(count)
                                        }
                                    } else {
                                        if -valueWidth > geometryScreen && -self.count != halfOfStoreItems {
                                            self.count -= 1
                                        }

                                        // Adjust our carousel scrolling for different iPhones
                                        switch screenSize {
                                        case .big:
                                            self.offsetX = (geometryWidth - 30) * CGFloat(count)
                                        case .medium:
                                             self.offsetX = (geometryWidth - 30) * CGFloat(count)
                                        case .small:
                                            self.offsetX = (geometryWidth - 30) * CGFloat(count)
                                        }
                                    }
                                }
                            })
                    )
                }
            }
            .offset(x: geometryOffset)
        }.frame(height: 182)
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView(trade: Trade.example, screenSize: .big)
    }
}
