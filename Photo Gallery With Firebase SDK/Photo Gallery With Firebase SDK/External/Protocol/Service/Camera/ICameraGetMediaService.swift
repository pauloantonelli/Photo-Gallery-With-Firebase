//
//  ICameraGetMediaService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 02/11/22.
//

import Foundation
import UIKit

protocol ICameraGetMediaService {
    func execute() throws -> UIImage
}
