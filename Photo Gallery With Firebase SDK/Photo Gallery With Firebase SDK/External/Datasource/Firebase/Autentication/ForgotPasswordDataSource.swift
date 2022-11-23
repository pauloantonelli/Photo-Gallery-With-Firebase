//
//  ForgotPasswordDataSource.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 23/11/22.
//

import Foundation

public struct ForgotPasswordDataSource: IForgotPasswordDataSource {
    let firebaseService: IFirebaseService
    
    public init(firebaseService: IFirebaseService) {
        self.firebaseService = firebaseService
    }
    
    public func execute(withEmail email: Email) async throws -> Bool {
        do {
            let result = try await self.firebaseService.forgotPassword(withEmail: email.value)
            return result
        } catch {
            throw ForgotPasswordErrorDataSource(message: "Error on ForgotPasswordDataSource \(error.localizedDescription)")
        }
    }
}
