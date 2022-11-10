//
//  IGetMediaListDrive.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 10/11/22.
//

import Foundation

protocol IGetMediaListDrive {
    func execute() async -> Result<Array<URL>, GetMediaListErrorUseCase>
}
