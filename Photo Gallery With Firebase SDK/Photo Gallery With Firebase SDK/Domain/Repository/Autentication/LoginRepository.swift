//
//  LoginRepository.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 27/10/22.
//

import Foundation

struct LoginRepository: ILoginRepository {
    let datasource: LoginDataSource
    
    init(datasource: LoginDataSource = LoginDataSource(firebase: DependencyInjection.shared.resolve(IFirebaseService.self)!)) {
        self.datasource = datasource
    }
    
    func execute(withCredential credential: Credential) async -> Result<User, LoginErrorUseCase> {
        do {
            let result = try await self.datasource.execute(withCredential: credential)
            return .success(result)
        } catch let error as LoginErrorDataSource {
            return .failure(error)
        } catch {
            return .failure(LoginErrorRepository(message: "Error on LoginErrorRepository"))
         }
    }
}
