//
//  IFirebaseStorageService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 08/11/22.
//

import Foundation
import UIKit
import FirebaseStorage

protocol IFirebaseStorageService {
    func add(imagePath: String, imageName: String, imageExtension: String) async -> Bool?
    func get(imageName: String, imageExtension: String) async -> URL?
    func delete(imageName: String, imageExtension: String) async -> Bool
    func download(fromURL: String, completion: @escaping (UIImage?) -> Void) -> Void
    func listMedia(completion: @escaping (Array<UIImage>) -> Void) async -> Void
    func storageMetadataFactory(imageName: String, imageExtension: String) -> StorageMetadata
}
