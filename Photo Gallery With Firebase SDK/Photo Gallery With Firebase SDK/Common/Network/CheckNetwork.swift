//
//  CheckNetwork.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 25/10/22.
//

import Foundation
import Network

class CheckNetwork: ICheckNetwork {
    fileprivate var monitor: NWPathMonitor
    var hasConnection: Bool = false
    
    init(monitor: NWPathMonitor = NWPathMonitor()) {
        self.monitor = monitor
        self.prepare()
        self.initMonitor { isConnected in
            self.updateHasConnection(isConnected)
        }
    }
    
    fileprivate func prepare() -> Void  {
        let queue = DispatchQueue(label: "Monitor")
        self.monitor.start(queue: queue)
    }
    
    func initMonitor(withCompletion completion: @escaping (Bool) -> Void) -> Void {
        self.monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("We're connected!")
                completion(true)
                return
            }
            completion(false)
            print("No connection.")
        }
    }
    
    fileprivate func updateHasConnection(_ status: Bool) -> Void {
        self.hasConnection = status
    }
}
