//
//  DetailView.swift
//  TestApp
//
//  Created by Andrew Ushakov on 8/28/22.
//

import SwiftUI

struct DetailView: View {
    @State private var details = Details.example
    @Environment(\.dismiss) var dismiss

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
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
                        .padding(.trailing, 55)
                        .onTapGesture {
                            dismiss()
                        }

                        Text("Product Details")
                            .font(.custom("MarkPro-Medium", size: 18))

                        NavigationLink(destination: CartView()) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color("Orange"))
                                    .frame(width: 37, height: 37)

                                Image(systemName: "bag")
                                    .foregroundColor(.white)
                                    .font(.callout)
                            }
                        }
                        .padding(.leading, 55)
                    }.offset(y: 15)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(details.images, id: \.self) { url in
                                GeometryReader { reader in
                                    let scale = getScale(reader: reader)

                                    AsyncImage(url: URL(string: url)) { image in
                                        image
                                            .resizable()
                                            .frame(width: geometry.size.width / 2, height: geometry.size.height / 3)
                                            .cornerRadius(20)
                                            .shadow(radius: 5)
                                            .scaleEffect(CGSize(width: scale, height: scale))

                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                                .frame(width: 266, height: 335)
                                .padding(.top, 50)
                            }
                        }
                        .offset(x: 20)
                        .padding(.horizontal, 70)
                    }

                    Spacer()
                }

                DetailBottomView(details: details)
            }
        }
        .navigationBarBackButtonHidden()
        .task {
            do {
                let url = URL(string: "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5")!
                let (data, _) = try await URLSession.shared.data(from: url)
                details = try JSONDecoder().decode(Details.self, from: data)
            } catch {
                details = Details.example
            }
        }
    }

    func getScale(reader: GeometryProxy) -> CGFloat {
        var scale: CGFloat = 1

        let offsetX = reader.frame(in: .global).minX

        let difference = offsetX

        if difference > 100 && difference < 195 {
            scale = 1 + (200 - difference) / 500
        } else if difference == 100 {
            scale = 1.2
        } else if difference < 100  && difference > 5 {
            scale = 1 + (difference) / 500
        }

        return scale
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
