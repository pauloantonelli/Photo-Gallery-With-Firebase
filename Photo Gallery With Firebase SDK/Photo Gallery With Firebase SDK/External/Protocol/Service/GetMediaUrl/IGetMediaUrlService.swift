//
//  IGetMediaUrlService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 09/11/22.
//

import Foundation

protocol IGetMediaUrlService {
    func execute(imageName: String, imageExtension: String) async throws -> URL
}
