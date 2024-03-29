//
//  IMediaPermissionServiceDelegate.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 05/11/22.
//

import Foundation

public protocol IMediaPermissionServiceDelegate {
    func updatePermitionStatus(status: Bool) -> Void
}
