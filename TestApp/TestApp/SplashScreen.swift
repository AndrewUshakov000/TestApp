//
//  SplashScreen.swift
//  TestApp
//
//  Created by Andrew Ushakov on 9/1/22.
//

import SwiftUI

struct SplashScreen: View {
    @State private var animationValues: [Bool] = Array(repeating: false, count: 4)

    var body: some View {
        ZStack {
            Color("Blue").ignoresSafeArea()

            if animationValues[0] {
                Circle()
                    .foregroundColor(Color("Orange"))
                    .frame(width: 132, height: 132)
            }

            VStack(alignment: .leading, spacing: -7) {
                if animationValues[1] {
                    Text("Ecommerce")
                        .foregroundColor(.white)
                        .font(.custom("DSLCLU+MarkPro-Heavy", size: 30))
                }

                if animationValues[2] {
                    Text("Concept")
                        .foregroundColor(.white)
                        .font(.custom("DSLCLU+MarkPro-Heavy", size: 30))
                }
            }.offset(x: 40)
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                withAnimation {
                    animationValues[0] = true
                }

                withAnimation(.easeInOut(duration: 0.4).delay(0.5)) {
                    animationValues[1] = true
                }

                withAnimation(.easeInOut(duration: 0.4).delay(1.0)) {
                    animationValues[2] = true
                }

                withAnimation(.easeInOut(duration: 0.4).delay(1.5)) {
                    animationValues[3] = true
                }
            }
        }
        .opacity(animationValues[3] ? 0 : 1)
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
