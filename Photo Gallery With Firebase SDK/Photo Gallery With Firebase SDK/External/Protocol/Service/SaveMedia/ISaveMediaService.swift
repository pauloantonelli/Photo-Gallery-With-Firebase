//
//  SaveMediaService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 08/11/22.
//

import Foundation
import UIKit

public protocol ISaveMediaService {
    func execute(fileName: String, image: UIImage) async throws -> Bool
}
