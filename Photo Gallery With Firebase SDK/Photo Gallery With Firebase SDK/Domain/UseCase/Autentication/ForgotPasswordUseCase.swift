//
//  ForgotPasswordUseCase.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 23/11/22.
//

import Foundation

public struct ForgotPasswordUseCase: IForgotPasswordUseCase {
    let repository: IForgotPasswordRepository
    
    public init(repository: IForgotPasswordRepository = ForgotPasswordRepository()) {
        self.repository = repository
    }
    
    public func execute(withEmail email: Email) async -> Result<Bool, ForgotPasswordErrorUseCase> {
        if email.isInvalid {
            return .failure(ForgotPasswordErrorUseCase(message: "Email is invalid"))
        }
        let result = await self.repository.execute(withEmail: email)
        return result
    }
}
