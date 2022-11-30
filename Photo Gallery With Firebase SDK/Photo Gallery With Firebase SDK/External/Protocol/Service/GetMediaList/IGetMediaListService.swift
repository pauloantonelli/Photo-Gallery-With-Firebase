//
//  IGetMediaListService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 10/11/22.
//

import Foundation

public protocol IGetMediaListUrlService {
    func execute() async throws -> Array<URL>
}
