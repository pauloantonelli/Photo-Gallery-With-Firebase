//
//  LaunchScreen.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 22/12/22.
//

import SwiftUI

struct LaunchScreen: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "swift")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .frame(
                    minWidth: 0.0,
                    maxWidth: 292.0,
                    minHeight: 0.0,
                    maxHeight: 155.0
                )
                .padding(.bottom, 65.0)
            Image("firebase-logo-2")
                .resizable()
                .aspectRatio(contentMode: .fit)
            LoadingView(color: .white)
            Spacer()
        }
        .padding(.horizontal, 40.0)
        .background(Color("BackgroundColor"))
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
