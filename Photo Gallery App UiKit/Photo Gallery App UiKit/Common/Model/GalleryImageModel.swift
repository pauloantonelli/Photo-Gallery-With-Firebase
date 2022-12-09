//
//  GalleryImage.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 07/12/22.
//

import Foundation
import UIKit

struct GalleryImageModel {
    let id: String
    let image: UIImage
    var imageIndex: Int
    
    init(id: String, image: UIImage, imageIndex: Int = 0) {
        self.id = id
        self.image = image
        self.imageIndex = imageIndex
    }
}
