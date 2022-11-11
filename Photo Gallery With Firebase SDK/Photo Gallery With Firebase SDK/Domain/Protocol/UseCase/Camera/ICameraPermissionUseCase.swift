//
//  ICameraPermission.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 31/10/22.
//

import Foundation

public protocol ICameraPermissionUseCase {
    func execute() async -> Result<Bool, CameraPermissionErrorUseCase>
}
