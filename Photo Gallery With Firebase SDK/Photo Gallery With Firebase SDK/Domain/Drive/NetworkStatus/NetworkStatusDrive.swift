//
//  NetworkStatusDrive.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 02/11/22.
//

import Foundation

struct NetworkStatusDrive: INetworkStatusDrive {
    let service: INetworkStatusService
    
    init(service: INetworkStatusService) {
        self.service = service
    }
    
    func execute() async -> Result<Bool, NetworkStatusErrorUseCase> {
        do {
            let result = try await self.service.execute()
            return .success(result)
        } catch let error as NetworkStatusErrorDrive {
            return .failure(error)
        } catch {
            return .failure(NetworkStatusErrorDrive(message: "Error on NetworkStatusErrorDrive \(error.localizedDescription)"))
        }
    }
}
