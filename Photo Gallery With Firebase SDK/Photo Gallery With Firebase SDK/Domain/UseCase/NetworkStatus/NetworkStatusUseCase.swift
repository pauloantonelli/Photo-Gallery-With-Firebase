//
//  NetworkStatusUseCase.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 02/11/22.
//

import Foundation

struct NetworkStatusUseCase: INetworkStatusUseCase {
    let drive: INetworkStatusDrive
    
    init(drive: INetworkStatusDrive) {
        self.drive = drive
    }
    
    func execute() async -> Result<Bool, NetworkStatusGetMediaErrorUseCase> {
        let result = await self.drive.execute()
        return result
    }
}
