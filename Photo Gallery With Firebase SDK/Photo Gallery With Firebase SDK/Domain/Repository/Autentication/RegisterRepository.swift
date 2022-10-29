//
//  RegisterRepository.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 27/10/22.
//

import Foundation

struct RegisterRepository: IRegisterRepository {
    let datasource: RegisterDataSource
    
    init(datasource: RegisterDataSource = RegisterDataSource(firebase: DependencyInjection.get(IFirebaseService.self)!)) {
        self.datasource = datasource
    }
    
    func execute(withCredential credential: Credential) async -> Result<User, RegisterErrorUseCase> {
        do {
            let result = try await self.datasource.execute(withCredential: credential)
            return .success(result)
        } catch let error as RegisterErrorDataSource {
            return .failure(error)
        } catch {
            return .failure(RegisterErrorRepository(message: "Error on RegisterErrorRepository"))
        }
    }
}
