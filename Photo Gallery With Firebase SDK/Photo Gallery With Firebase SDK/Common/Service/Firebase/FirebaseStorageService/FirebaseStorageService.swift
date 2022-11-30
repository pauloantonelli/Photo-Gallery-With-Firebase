//
//  FirebaseStorageService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 08/11/22.
//

import Foundation
import UIKit
import FirebaseStorage

public struct FirebaseStorageService: IFirebaseStorageService {
    fileprivate let storage: Storage
    fileprivate let storageReference: StorageReference
    fileprivate let rootReference: String = "media"
    
    public init(storage: Storage = Storage.storage()) {
        self.storage = storage
        self.storageReference = storage.reference()
    }
    
    public func add(imagePath localFile: URL, imageName: String, imageExtension: String) async throws -> Bool? {
        let imagesRef = self.storageReference.child("\(self.rootReference)/\(imageName).\(imageExtension)")
        do {
            let metadata = try await imagesRef.putFileAsync(from: localFile, metadata: self.storageMetadataFactory(imageName: imageName, imageExtension: imageExtension))
            if metadata.size == 0 {
                return false
            }
            return true
        } catch {
            print("Error on FirebaseStorageService add: \(error.localizedDescription)")
            return nil
        }
    }
    
    public func get(imageName: String, imageExtension: String) async throws -> URL? {
        let imageReference = self.storageReference.parent()?.child("\(imageName).\(imageExtension)")
        do {
            let result = try await imageReference?.downloadURL()
            return result
        } catch {
            print("Error on FirebaseStorageService get: \(error.localizedDescription)")
            return nil
        }
    }
    
    public func delete(imageName: String, imageExtension: String) async throws -> Bool {
        let imageReference = self.storageReference.child("\(self.rootReference)/\(imageName).\(imageExtension)")
        do {
            let _ = try await imageReference.delete()
            return true
        } catch {
            print("Error on FirebaseStorageService delete: \(error.localizedDescription)")
            return false
        }
    }
    
    public func getList() async throws -> Array<URL> {
        do {
            let imageReference: StorageListResult? = try await self.storageReference.child(self.rootReference).listAll()
            let urlList: Array<URL>? = imageReference?.items.map({ item in
                let url = URL(string: item.name)!
                return url
            })
            return urlList ?? []
        } catch {
            print("Error on FirebaseStorageService listMedia: \(error.localizedDescription)")
            return []
        }
    }
    
    public func download(withUrl url: URL, completion: @escaping (UIImage?) -> Void) -> Void {
        let imageReference = self.storageReference.child("\(self.rootReference)/\(url.absoluteString)")
        let task = imageReference.getData(maxSize: .max, completion: { (data, error) in
            if error != nil {
                print("Error on FirebaseStorageService download: \(error!.localizedDescription)")
                completion(nil)
                return
            }
            guard let image = data else {
                print("Error on FirebaseStorageService download: \(error!.localizedDescription)")
                completion(nil)
                return
            }
            let downloadedImage = UIImage(data: image)
            completion(downloadedImage)
        })
        task.resume()
    }
    
    public func storageMetadataFactory(imageName: String, imageExtension: String) -> StorageMetadata {
        let metadata = StorageMetadata()
        metadata.contentType = "\(imageName).\(imageExtension)"
        return metadata
    }
}
