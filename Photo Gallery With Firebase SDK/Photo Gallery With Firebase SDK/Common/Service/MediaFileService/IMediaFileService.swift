//
//  IMediaFileService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 08/11/22.
//

import Foundation
import UIKit

public protocol IMediaFileService {
    var documentsUrl: URL { get }
    
    func save(fileName: String, image: UIImage) -> String?
    func load(fileName: String) -> UIImage?
    func filePath(fileName: String) -> URL
}
