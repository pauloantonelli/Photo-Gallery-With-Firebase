//
//  GalleryPermissionService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 01/11/22.
//

import Foundation

public protocol IGalleryPermissionService {
    func execute() async throws -> Result<Bool, GalleryPermissionErrorService>
}
