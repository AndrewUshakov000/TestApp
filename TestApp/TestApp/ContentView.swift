//
//  ContentView.swift
//  TestApp
//
//  Created by Andrew Ushakov on 8/24/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                SplashScreen()
                    .zIndex(1)

                ZStack(alignment: .bottom) {
                    HomeView()

                    CustomTabBar().offset(y: 35)
                }
                .zIndex(0)
            }
            .toolbar(.hidden)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
