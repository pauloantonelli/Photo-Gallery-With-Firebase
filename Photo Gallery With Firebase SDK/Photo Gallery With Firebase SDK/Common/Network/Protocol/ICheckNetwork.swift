//
//  ICheckNetwork.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 03/11/22.
//

import Foundation
import Network

protocol ICheckNetwork {
    var hasConnection: Bool { get set }
    
    func initMonitor(withCompletion completion: @escaping (Bool) -> Void) -> Void
}
