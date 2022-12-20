//
//  GalleryImageModel.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 20/12/22.
//

import Foundation
import SwiftUI

struct GalleryImageModel: Identifiable {
    let id: String
    let image: Image
    var imageIndex: Int
    
    init(id: String, image: Image, imageIndex: Int = 0) {
        self.id = id
        self.image = image
        self.imageIndex = imageIndex
    }
}
