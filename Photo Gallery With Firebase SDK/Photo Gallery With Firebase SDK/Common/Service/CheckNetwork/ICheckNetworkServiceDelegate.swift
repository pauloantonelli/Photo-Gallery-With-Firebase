//
//  CheckNetworkDelegate.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 05/11/22.
//

import Foundation

public protocol ICheckNetworkServiceDelegate {
    func updateNetworkStatus(status: Bool) -> Void
}
