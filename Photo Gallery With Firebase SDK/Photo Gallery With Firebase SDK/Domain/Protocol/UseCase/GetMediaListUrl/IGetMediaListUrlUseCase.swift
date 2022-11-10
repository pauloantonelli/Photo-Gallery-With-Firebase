//
//  IGetMediaListUrlUseCase.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 10/11/22.
//

import Foundation

protocol IGetMediaListUrlUseCase {
    func execute() async -> Result<Array<URL>, GetMediaListUrlErrorUseCase>
}
