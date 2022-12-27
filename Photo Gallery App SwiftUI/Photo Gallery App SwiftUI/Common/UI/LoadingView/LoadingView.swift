//
//  LoadingView.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 22/12/22.
//

import SwiftUI

struct LoadingView: View {
    @State var color: Color = Color("BackgroundColor")
    @State var width: Double = 50.0
    @State var height: Double = 50.0
    
    var body: some View {
        ActivityIndicatorView(color: self.color)
            .frame(width: self.width, height: self.height)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
