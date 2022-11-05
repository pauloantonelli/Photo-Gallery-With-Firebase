//
//  ICheckNetwork.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 05/11/22.
//

import Foundation
import Network

protocol ICheckNetwork {
    var currentConnectionType: NWInterface.InterfaceType { get set }
    var hasConnection: Bool { get set }
    var delegate: CheckNetworkDelegate? { get set }
   
    func initMonitor() -> Void
    func stopMonitor() -> Void
}
