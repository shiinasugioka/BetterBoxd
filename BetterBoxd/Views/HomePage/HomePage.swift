//
//  HomePage.swift
//  BetterBoxd
//
//  Created by Shiina on 5/24/24.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        ZStack {
            Color.darkBlue.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Home Page Content")
                    .foregroundColor(.foregroundWhite)
            }
        }
    }
}

#Preview {
    HomePage()
}
