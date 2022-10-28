//
//  LoginUseCase.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 27/10/22.
//

import Foundation

struct LoginUseCase: ILoginUseCase {
    let repository: LoginRepository
    
    init(repository: LoginRepository) {
        self.repository = repository
    }
    
    func execute(withCredential credential: Credential) async -> Result<User, LoginErrorUseCase> {
        if credential.email.isInvalid {
            return .failure(LoginErrorUseCase(message: "Email is invalid"))
        }
        if credential.password.isInvalid {
            return .failure(LoginErrorUseCase(message: "Password is invalid"))
        }
        let result = await self.repository.execute(withCredential: credential)
       return result
    }
}
