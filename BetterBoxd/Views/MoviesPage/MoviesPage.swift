//
//  MoviesPage.swift
//  BetterBoxd
//
//  Created by Shiina on 5/28/24.
//

import SwiftUI

struct MoviesPage: View {
    var body: some View {
        ZStack {
            Color.darkBlue.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Movies Page Content")
                    .foregroundColor(.foregroundWhite)
            }
        }
    }
}

#Preview {
    MoviesPage()
}
