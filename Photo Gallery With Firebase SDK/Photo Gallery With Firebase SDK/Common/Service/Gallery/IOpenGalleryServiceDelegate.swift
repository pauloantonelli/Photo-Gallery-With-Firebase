//
//  IOpenGalleryServiceDelegate.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 05/11/22.
//

import Foundation
import UIKit

protocol IOpenGalleryServiceDelegate {
    func updateImage(withImage image: UIImage) -> Void
}
