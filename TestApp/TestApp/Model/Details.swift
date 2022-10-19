//
//  Phone.swift
//  TestApp
//
//  Created by Andrew Ushakov on 8/26/22.
//

// swiftlint:disable all

import Foundation

struct Details: Identifiable, Decodable {
    let id: String

    let CPU: String
    let camera: String
    let capacity: [String]
    let color: [String]
    let images: [String]
    let isFavorites: Bool
    let price: Int
    let rating: Double
    let sd: String
    let ssd: String
    let title: String

    static let example = Details(
        id: "",
        CPU: "",
        camera: "",
        capacity: [""],
        color: [""],
        images: [""],
        isFavorites: true,
        price: 0,
        rating: 0,
        sd: "",
        ssd: "",
        title: ""
    )
}
