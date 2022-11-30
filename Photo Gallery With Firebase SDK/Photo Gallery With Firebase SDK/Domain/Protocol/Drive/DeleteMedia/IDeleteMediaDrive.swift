//
//  IDeleteMediaDrive.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 10/11/22.
//

import Foundation

public protocol IDeleteMediaDrive {
    func execute(imageName: String, imageExtension: String) async -> Result<Bool, DeleteMediaErrorUseCase>
}
