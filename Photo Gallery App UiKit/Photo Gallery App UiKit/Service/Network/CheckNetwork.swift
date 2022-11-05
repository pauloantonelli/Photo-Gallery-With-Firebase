//
//  CheckNetwork.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 05/11/22.
//

import Foundation
import Network

class CheckNetwork: ICheckNetwork {
    fileprivate let monitor: NWPathMonitor
    fileprivate let dispatchQueue: DispatchQueue = DispatchQueue(label: "Monitor")
    fileprivate let connectionTypeList: Array<NWInterface.InterfaceType> = [.wifi, .cellular]
    var currentConnectionType: NWInterface.InterfaceType = .wifi
    var hasConnection: Bool = false
    var delegate: CheckNetworkDelegate?
    
    init(monitor: NWPathMonitor = NWPathMonitor()) {
        self.monitor = monitor
        self.prepare()
        self.initMonitor()
    }
    
    fileprivate func prepare() -> Void  {
        self.monitor.start(queue: self.dispatchQueue)
    }
    
    func initMonitor() -> Void {
        self.monitor.pathUpdateHandler = { [weak self] path in
            self?.updateHasConnection(path)
            self?.updateCurrentConnectionType(path)
        }
    }
    
    func stopMonitor() -> Void {
        self.monitor.cancel()
    }
    
    fileprivate func updateCurrentConnectionType(_ path: NWPath) -> Void {
        guard let currentInterface = self.connectionTypeList.filter({path.usesInterfaceType($0)}).first else {
            fatalError("Connection Type Unknown")
        }
        self.currentConnectionType = currentInterface
    }
    
    fileprivate func updateHasConnection(_ path: NWPath) -> Void {
        if path.status == .satisfied {
            self.hasConnection = true
            DispatchQueue.main.async {
                self.delegate?.updateNetworkStatus(status: true)
            }
            return
        }
        self.hasConnection = false
        DispatchQueue.main.async {
            self.delegate?.updateNetworkStatus(status: false)
        }
    }
}
