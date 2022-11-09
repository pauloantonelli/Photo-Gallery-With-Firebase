//
//  MediaFileService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 08/11/22.
//

import Foundation
import UIKit

struct MediaFileService: IMediaFileService {
    var documentsUrl: URL {
        let result = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return result
    }
    
    func save(fileName: String, image: UIImage) -> String? {
        let fileUrl = self.filePath(fileName: fileName)
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            fatalError("Error on MediaFileService save")
        }
        do {
            let _ = try imageData.write(to: fileUrl, options: .atomic)
            return fileName
        } catch {
            fatalError("Error on MediaFileService save: \(error.localizedDescription)")
        }
    }
    
    func load(fileName: String) -> UIImage? {
        let fileUrl = self.filePath(fileName: fileName)
        do {
            let result = try Data(contentsOf: fileUrl)
            return UIImage(data: result)
        } catch {
            fatalError("Error on MediaFileService load: \(error.localizedDescription)")
        }
    }
    
    func filePath(fileName: String) -> URL {
        let fileUrl = self.documentsUrl.appendingPathComponent(fileName)
        return fileUrl
    }
}
