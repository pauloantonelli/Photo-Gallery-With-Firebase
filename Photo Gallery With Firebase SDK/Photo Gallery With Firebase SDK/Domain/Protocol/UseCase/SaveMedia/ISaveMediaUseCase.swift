//
//  ISaveMedia.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 08/11/22.
//

import Foundation
import UIKit

public protocol ISaveMediaUseCase {
    func execute(fileName: String, image: UIImage) async -> Result<Bool, SaveMediaErrorUseCase>
}
