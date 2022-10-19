//
//  Phone.swift
//  TestApp
//
//  Created by Andrew Ushakov on 8/24/22.
//

// swiftlint:disable all

import Foundation

struct Home: Identifiable, Decodable {
    let id: Int

    let is_new: Bool?
    let title: String
    let subtitle: String
    let picture: String
    let is_buy: Bool

    static let example = Home(id: 0, is_new: false, title: "", subtitle: "", picture: "", is_buy: false)
}

struct Best: Identifiable, Decodable {
    let id: Int

    var is_favorites: Bool
    let title: String
    let price_without_discount: Int
    let discount_price: Int
    let picture: String

    static let example = Best(
        id: 0,
        is_favorites: false,
        title: "",
        price_without_discount: 0,
        discount_price: 0,
        picture: ""
    )
}

struct Trade: Decodable {
    let home_store: [Home]
    let best_seller: [Best]
    
    static let example = Trade(home_store: [Home.example], best_seller: [Best.example])
}
