//
//  ProfilePage.swift
//  BetterBoxd
//
//  Created by Shiina on 5/28/24.
//

import SwiftUI

struct ProfilePage: View {
    var body: some View {
        ZStack {
            Color.darkBlue.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Profile Page Content")
                    .foregroundColor(.foregroundWhite)
                
                
            }
        }
    }
}

//#Preview {
//    ProfilePage()
//}
struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
            .previewDevice("iPhone 12")
        ProfilePage()
            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
    }
}

