//
//  LoginRepository.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 27/10/22.
//

import Foundation

struct LoginRepository: ILoginRepository {
    let datasource: LoginDataSource
    
    init(datasource: LoginDataSource = LoginDataSource()) {
        self.datasource = datasource
    }
    
    func execute(withCredential credential: Credential) async -> Result<User, LoginError> {
        do {
            let result = try await self.datasource.execute(withCredential: credential)
            return .success(result)
        } catch let error as LoginError {
           return .failure(error)
        } catch {
            return .failure(.repository)
         }
    }
}
