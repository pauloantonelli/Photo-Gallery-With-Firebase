//
//  IGetMediaUrl.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 09/11/22.
//

import Foundation

protocol IGetMediaUrlUseCase {
    func execute(imageName: String, imageExtension: String) async -> Result<URL, GetMediaUrlErrorUseCase>
}
