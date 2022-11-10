//
//  FirebaseStorageService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 08/11/22.
//

import Foundation
import UIKit
import FirebaseStorage

struct FirebaseStorageService: IFirebaseStorageService {
    fileprivate let storage: Storage
    fileprivate let storageReference: StorageReference
    fileprivate let rootReference: String = "media"
    
    init(storage: Storage = Storage.storage()) {
        self.storage = storage
        self.storageReference = storage.reference()
    }
    
    func add(imagePath: String, imageName: String, imageExtension: String) async throws -> Bool? {
        let localFile = URL(string: imagePath)!
        let imagesRef = self.storageReference.child("\(self.rootReference)/\(imageName).\(imageExtension)")
        do {
            let metadata = try await imagesRef.putFileAsync(from: localFile, metadata: self.storageMetadataFactory(imageName: imageName, imageExtension: imageExtension))
            if metadata.size == 0 {
                return false
            }
            return true
        } catch {
            fatalError("Error on FirebaseStorageService add: \(error.localizedDescription)")
        }
    }
    
    func get(imageName: String, imageExtension: String) async throws -> URL? {
//        let pathReference = storage.reference(withPath: "\(rootReference)/\(imageName).\(imageExtension)")
        let imageReference = self.storageReference.parent()?.child("\(imageName).\(imageExtension)")
        do {
            let result = try await imageReference?.downloadURL()
            return result
        } catch {
            fatalError("Error on FirebaseStorageService get: \(error.localizedDescription)")
        }
    }
    
    func delete(imageName: String, imageExtension: String) async throws -> Bool {
        let imageReference = self.storageReference.parent()?.child("\(imageName).\(imageExtension)")
        do {
            let _ = try await imageReference?.delete()
            return true
        } catch {
            fatalError("Error on FirebaseStorageService delete: \(error.localizedDescription)")
        }
    }
    
    func getList() async throws -> Array<URL> {
        do {
            let imageReference: StorageListResult? = try await self.storageReference.listAll()
            let urlList: Array<URL>? = imageReference?.items.map({ item in
                let url = URL(string: item.name)!
                return url
            })
            return urlList ?? []
//            urlList?.forEach({ url in
//                self.download(fromURL: url) { downloadImage in
//                    guard let image = downloadImage else {
//                        print("Error on FirebaseStorageService listMedia > download")
//                        return
//                    }
//                    imageList.append(image)
//                }
//            })
//            completion(imageList)
        } catch {
            fatalError("Error on FirebaseStorageService listMedia: \(error.localizedDescription)")
        }
    }
    
    func download(fromURL: String, completion: @escaping (UIImage?) -> Void) -> Void {
        let imageReference = self.storageReference.parent()?.child(fromURL)
        let task = imageReference?.getData(maxSize: 1 * 1024 * 1024, completion: { (data, error) in
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
        task?.resume()
    }
    
    func storageMetadataFactory(imageName: String, imageExtension: String) -> StorageMetadata {
        let metadata = StorageMetadata()
        metadata.contentType = "\(imageName).\(imageExtension)"
        return metadata
    }
}
