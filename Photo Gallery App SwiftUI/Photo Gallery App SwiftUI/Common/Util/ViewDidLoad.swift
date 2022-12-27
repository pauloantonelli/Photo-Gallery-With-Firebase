//
//  ViewDidLoad.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 22/12/22.
//

import SwiftUI

struct ViewDidLoad: ViewModifier {
    @State private var didLoad: Bool = false
    private let action: (() -> Void)?
    
    init(perform action: (() -> Void)? = nil) {
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content.onAppear {
            if self.didLoad == false {
                self.didLoad = true
                self.action?()
            }
        }
    }
}
