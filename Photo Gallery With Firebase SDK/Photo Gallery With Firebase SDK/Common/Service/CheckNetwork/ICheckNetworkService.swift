//
//  ICheckNetwork.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 05/11/22.
//

import Foundation
import Network

public protocol ICheckNetworkService {
    var currentConnectionType: NWInterface.InterfaceType { get set }
    var hasConnection: Bool { get set }
    var delegate: ICheckNetworkServiceDelegate? { get set }
   
    func initMonitor() -> Void
    func stopMonitor() -> Void
}
