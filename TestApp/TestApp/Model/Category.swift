//
//  Category.swift
//  TestApp
//
//  Created by Andrew Ushakov on 8/25/22.
//

import Foundation

struct Category: Identifiable {
    var id: String { name }

    let name: String
    let width: CGFloat
    let height: CGFloat
}
