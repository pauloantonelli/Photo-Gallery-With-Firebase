//
//  CheckNetwork.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 05/11/22.
//

import Foundation
import Network

public class CheckNetworkService: ICheckNetworkService {
    fileprivate let monitor: NWPathMonitor
    fileprivate let dispatchQueue: DispatchQueue = DispatchQueue(label: "Monitor")
    fileprivate let connectionTypeList: Array<NWInterface.InterfaceType> = [.wifi, .cellular]
    public var currentConnectionType: NWInterface.InterfaceType = .wifi
    public var hasConnection: Bool = false
    public var delegate: ICheckNetworkServiceDelegate?
    
    public init(monitor: NWPathMonitor = NWPathMonitor()) {
        self.monitor = monitor
        self.prepare()
        self.initMonitor()
    }
    
    fileprivate func prepare() -> Void  {
        self.monitor.start(queue: self.dispatchQueue)
    }
    
    public func initMonitor() -> Void {
        self.monitor.pathUpdateHandler = { [weak self] path in
            self?.updateHasConnection(path)
            self?.updateCurrentConnectionType(path)
        }
    }
    
    public func stopMonitor() -> Void {
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
