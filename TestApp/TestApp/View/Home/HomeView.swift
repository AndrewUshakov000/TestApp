//
//  HomeView.swift
//  TestApp
//
//  Created by Andrew Ushakov on 8/24/22.
//

import SwiftUI

struct HomeView: View {
    let columns = [GridItem(.fixed(200), spacing: 0), GridItem(.fixed(200), spacing: 0)]

    let categories = [
        Category(name: "Phones", width: 18, height: 30),
        Category(name: "Computers", width: 29, height: 31),
        Category(name: "Health", width: 32, height: 30),
        Category(name: "Books", width: 21, height: 28)
    ]

    @State private var trade = Trade.example

    @State private var selectedCategory = "Phones"
    @State private var text = ""

    @State private var showFilter = false

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
        ScrollView(showsIndicators: false) {
            HStack {
                Spacer()

                HStack {
                    Image(systemName: "mappin.circle")
                        .foregroundColor(Color("Orange"))
                        .font(.callout)

                    Text("Zihuatanejo, Gro")
                        .font(.custom("MarkPro-Medium", size: 15))

                    Image(systemName: "chevron.down")
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .offset(y: 1)
                }.padding(.leading, 40)

                Spacer()

                Image(systemName: "list.bullet.indent")
                    .foregroundColor(Color("Blue"))
                    .font(.callout)
                    .padding(.trailing, 35)
                    .onTapGesture {
                        self.showFilter.toggle()
                    }
            }
            .padding(.top)
            .padding(.bottom, 5)

            TitleSection(title: "Select Category", supplement: "view all")

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(categories) { category in
                        Button {
                            self.selectedCategory = category.id
                        } label: {
                            VStack {
                                ZStack {
                                    Circle()
                                        .foregroundColor(selectedCategory == category.id ? Color("Orange") : .white)
                                        .frame(width: 71, height: 71)

                                    Image(category.name)
                                        .resizable()
                                        .frame(width: category.width, height: category.height)
                                        .foregroundColor(selectedCategory == category.id ? .white : .gray)
                                }

                                Text(category.name)
                                    .font(.custom("MarkPro-Medium", size: 12))
                                    .foregroundColor(selectedCategory == category.id ? Color("Orange") : .black)
                            }
                        }
                        .padding(.leading, 17)
                        .shadow(color: .black.opacity(0.15), radius: 4)
                    }
                }
                .padding(.leading)
                .padding(.top, 10)
            }

            HStack {
                CustomTextField(textField: TextField("Search", text: $text))

                ZStack {
                    Circle()
                        .foregroundColor(Color("Orange"))
                        .frame(width: 34, height: 34)

                    Image(systemName: "qrcode")
                        .foregroundColor(.white)

                }
            }.padding(.top, 30)

            TitleSection(title: "Hot sales", supplement: "see more")
                .offset(y: 10)

            CarouselView(trade: trade, screenSize: screenSize)

            TitleSection(title: "Best seller", supplement: "see more")

            LazyVGrid(columns: columns) {
                ForEach(trade.best_seller) { phone in
                    NavigationLink(destination: DetailView()) {
                        VStack(alignment: .leading) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.white)
                                    .frame(width: 187, height: 227)
                                    .shadow(color: .black.opacity(0.15), radius: 4)

                                VStack(alignment: .leading) {
                                    AsyncImage(url: URL(string: phone.picture), content: { image in
                                        image
                                            .resizable()
                                            .frame(width: 187, height: 168)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }, placeholder: {
                                        ProgressView()
                                    })

                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text("$\(phone.price_without_discount)")
                                                .foregroundColor(.black)
                                                .font(.custom("MarkPro-Bold", size: 16))

                                            Text("$\(phone.discount_price)")
                                                .foregroundColor(.secondary)
                                                .font(.custom("MarkPro-Medium", size: 10))
                                                .strikethrough(color: .secondary)
                                                .padding(.top, 5)
                                        }.padding(.bottom, 1)

                                        Text(phone.title)
                                            .font(.custom("MarkPro", size: 10))
                                            .foregroundColor(.black)

                                    }
                                    .padding(.leading, 20)
                                    .padding(.bottom, 25)
                                }

                                Button {
                                    // More code to come
                                } label: {
                                    ZStack {
                                        Circle()
                                            .frame(width: 25, height: 25)
                                            .foregroundColor(.white)
                                            .shadow(color: .black.opacity(0.15), radius: 4)

                                        Image(systemName: phone.is_favorites ? "heart.fill" : "heart")
                                            .font(.caption2)
                                            .foregroundColor(Color("Orange"))
                                    }
                                }.offset(x: 70, y: -100)
                            }
                        }
                    }
                }
            }.padding(.bottom, 60)
        }
        .padding(.horizontal, screenSize == .small ? 15 : 0)
        .background(Color(.black).opacity(0.05).ignoresSafeArea())
        .task {
            do {
                let url = URL(string: "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175")!
                let (data, _) = try await URLSession.shared.data(from: url)
                trade = try JSONDecoder().decode(Trade.self, from: data)
            } catch {
                trade = Trade.example
            }
        }
        .sheet(isPresented: $showFilter) {
            CustomFilter()
                .presentationDetents([.height(375)])
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
