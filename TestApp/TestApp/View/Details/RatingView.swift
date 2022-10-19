//
//  RatingView.swift
//  TestApp
//
//  Created by Andrew Ushakov on 8/29/22.
//

import SwiftUI

struct RatingView: View {
    private var maxRating: Float = 5

    let rating: Float
    private let fullCount: Int
    private let emptyCount: Int
    private let halfFullCount: Int

    init(rating: Float) {
        self.rating = rating
        fullCount = Int(rating)
        emptyCount = Int(maxRating - rating)
        halfFullCount = (Float(fullCount + emptyCount) < maxRating) ? 1 : 0
      }

    var body: some View {
        HStack {
            ForEach(0..<fullCount, id: \.self) { _ in
             Image(systemName: "star.fill")
          }
          ForEach(0..<halfFullCount, id: \.self) { _ in
              Image(systemName: "star.leadinghalf.filled")
          }
          ForEach(0..<emptyCount, id: \.self) { _ in
              Image(systemName: "star")
          }
        }.foregroundColor(.yellow)
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: 3.5)
    }
}
