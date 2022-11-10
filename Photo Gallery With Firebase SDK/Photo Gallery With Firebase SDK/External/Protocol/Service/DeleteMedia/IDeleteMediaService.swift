//
//  IDeleteMediaService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 10/11/22.
//

import Foundation

protocol IDeleteMediaService {
    func execute(imageName: String, imageExtension: String) async throws -> Bool
}
