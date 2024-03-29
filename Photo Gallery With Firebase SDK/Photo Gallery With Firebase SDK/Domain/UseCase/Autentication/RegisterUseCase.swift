//
//  RegisterUseCase.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 27/10/22.
//

import Foundation

public struct RegisterUseCase: IRegisterUseCase {
    let repository: IRegisterRepository
    
    public init(repository: IRegisterRepository = RegisterRepository()) {
        self.repository = repository
    }
    
    public func execute(withCredential credential: Credential) async -> Result<User, RegisterErrorUseCase> {
        if credential.email.isInvalid {
            return .failure(RegisterErrorUseCase(message: "Email is invalid"))
        }
        if credential.password.isInvalid {
            return .failure(RegisterErrorUseCase(message: "Password is invalid"))
        }
        let result = await self.repository.execute(withCredential: credential)
        return result
    }
}
