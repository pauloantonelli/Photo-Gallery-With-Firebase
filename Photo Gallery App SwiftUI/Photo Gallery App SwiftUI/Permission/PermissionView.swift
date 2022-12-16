//
//  PermissionView.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 14/12/22.
//

import SwiftUI

struct PermissionView: View {
    var body: some View {
        VStack {
            Image("permission")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(minHeight: 0.0, maxHeight: 150.0, alignment: .center)
                .padding(.bottom, 20.0)
            Text("Allow your Camera")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.black.opacity(0.7))
                .padding(.bottom, 20.0)
            Text("We will need your camera to give you better experience.")
                .font(.subheadline)
                .fontWeight(.thin)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20.0)
            Button(action: {
                self.grantPermition(status: true)
            }) {
              Text("Sure, I'd Like that")
                    .fontWeight(.bold)
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                maxHeight: 35.0
            )
            .foregroundColor(Color("PermissionButtonLabelColor"))
            .background(Color("PermissionButtonBackgroundColor"))
            .cornerRadius(5.0)
            .padding(.bottom, 10.0)
            Button(action: {
                self.grantPermition(status: false)
            }) {
                Text("Not now")
                    .fontWeight(.bold)
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                maxHeight: 35.0
            )
            .foregroundColor(Color("PermissionButtonBackgroundColor"))
            .background(.white)
            .cornerRadius(5.0)
            .padding(.bottom, 10.0)
        }
        .padding(.horizontal, 20.0)
    }
    
    func grantPermition(status: Bool) -> Void {
        
    }
}

struct PermissionView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionView()
    }
}
