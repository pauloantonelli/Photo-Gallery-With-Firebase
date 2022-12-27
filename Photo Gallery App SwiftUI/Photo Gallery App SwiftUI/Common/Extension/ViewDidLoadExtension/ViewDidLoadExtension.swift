//
//  ViewDidLoadExtension.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 22/12/22.
//

import SwiftUI

extension View {
    func onLoad(perform action:(() -> Void)? = nil) -> some View {
        modifier(ViewDidLoad(perform: action))
    }
}
