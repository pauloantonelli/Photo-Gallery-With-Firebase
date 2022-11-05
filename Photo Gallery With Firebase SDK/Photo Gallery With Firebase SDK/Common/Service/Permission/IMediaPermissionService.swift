//
//  IMediaPermissionService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 05/11/22.
//

import Foundation
import AVFoundation

protocol IMediaPermissionService {
    var authorizationStatus: AVAuthorizationStatus { get }
    var delegate: IMediaPermissionServiceDelegate? { get }
    
    func execute() -> Bool
}
