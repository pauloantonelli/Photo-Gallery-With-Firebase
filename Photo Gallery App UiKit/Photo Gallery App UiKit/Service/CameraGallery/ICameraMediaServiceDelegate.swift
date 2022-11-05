//
//  CameraGetMediaServiceDelegate.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 05/11/22.
//

import Foundation
import UIKit

protocol ICameraMediaServiceDelegate {
    func updateImage(withImage image: UIImage) -> Void
}
