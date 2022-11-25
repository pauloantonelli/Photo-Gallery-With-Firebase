//
//  IFirebaseServiceDelegate.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 24/11/22.
//

import Foundation

public protocol IFirebaseServiceDelegate {
    func updateUser(user: User) -> Void
}
