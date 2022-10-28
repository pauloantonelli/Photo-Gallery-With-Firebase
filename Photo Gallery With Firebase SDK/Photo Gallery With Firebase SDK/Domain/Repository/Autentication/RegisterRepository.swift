//
//  RegisterRepository.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 27/10/22.
//

import Foundation

struct RegisterRepository: IRegisterRepository {
    let datasource: RegisterDataSource
    
    init(datasource: RegisterDataSource = RegisterDataSource()) {
        self.datasource = datasource
    }
    
    func execute(withCredential credential: Credential) async -> Result<User, RegisterError> {
        do {
            let result = try await self.datasource.execute(withCredential: credential)
            return .success(result)
        } catch let error as RegisterError {
            return .failure(error)
        } catch {
            return .failure(.datasource)
        }
    }
}
