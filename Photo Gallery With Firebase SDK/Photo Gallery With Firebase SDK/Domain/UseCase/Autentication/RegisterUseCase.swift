//
//  RegisterUseCase.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 27/10/22.
//

import Foundation

struct RegisterUseCase: IRegisterUseCase {
    let repository: RegisterRepository
    
    init(repository: RegisterRepository) {
        self.repository = repository
    }
    
    func execute(withCredential credential: Credential) async -> Result<User, RegisterError> {
        let result = await self.repository.execute(withCredential: credential)
        return result
    }
}
