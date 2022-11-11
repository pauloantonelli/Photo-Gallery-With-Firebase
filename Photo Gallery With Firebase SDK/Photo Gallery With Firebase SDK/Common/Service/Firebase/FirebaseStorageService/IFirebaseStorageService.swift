//
//  IFirebaseStorageService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 08/11/22.
//

import Foundation
import UIKit
import FirebaseStorage

public protocol IFirebaseStorageService {
    func add(imagePath: String, imageName: String, imageExtension: String) async throws -> Bool?
    func get(imageName: String, imageExtension: String) async throws -> URL?
    func delete(imageName: String, imageExtension: String) async throws -> Bool
    func download(fromURL: String, completion: @escaping (UIImage?) -> Void) -> Void
    func getList() async throws -> Array<URL> 
    func storageMetadataFactory(imageName: String, imageExtension: String) -> StorageMetadata
}
