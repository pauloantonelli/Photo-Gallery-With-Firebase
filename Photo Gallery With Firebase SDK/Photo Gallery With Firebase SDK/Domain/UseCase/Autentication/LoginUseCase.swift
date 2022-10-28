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
    
    func execute(withCredential credential: Credential) async -> Result<User, LoginError> {
        let result = await self.repository.execute(withCredential: credential)
        return result
    }
}
