//
//  Сart.swift
//  TestApp
//
//  Created by Andrew Ushakov on 8/31/22.
//

import Foundation

struct Item: Identifiable, Decodable {
    let id: Int

    let images: String
    let price: Int
    let title: String

    static let example = Item(id: 0, images: "", price: 0, title: "")
}

struct Cart: Identifiable, Decodable {
    let id: String

    let basket: [Item]
    let delivery: String
    let total: Int

    static let example = Cart(id: "", basket: [Item.example], delivery: "", total: 0)
}
