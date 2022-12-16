//
//  GalleyDetailView.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 15/12/22.
//

import SwiftUI

struct GalleyDetailView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("swift-firebase")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.trailing, 20.0)
            Spacer()
            Button("Delete", action: self.executeDelete)
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    maxHeight: 65.0
                )
                .foregroundColor(.white)
                .background(Color("ButtonBackgroundColor"))
                .cornerRadius(5.0)
                .padding(.bottom, 10.0)
        }
        .padding(.horizontal, 20.0)
    }
    
    func executeDelete() -> Void {
        
    }
}

struct GalleyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GalleyDetailView()
    }
}
