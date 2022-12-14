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
            Text("Allow your Camera")
            Text("We will need your camera to give you better experience.")
            Button("Sure, I'd Like that", action: {
                self.grantPermition(status: true)
            })
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                maxHeight: 35.0
            )
            .foregroundColor(Color("PermissionButtonLabelColor"))
            .background(Color("PermissionButtonBackgroundColor"))
            .cornerRadius(5.0)
            .padding(.bottom, 10.0)
            Button("Not now", action: {
                self.grantPermition(status: false)
            })
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                maxHeight: 35.0
            )
            .foregroundColor(Color("PermissionButtonBackgroundColor"))
            .background(Color("PermissionButtonLabelColor"))
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
