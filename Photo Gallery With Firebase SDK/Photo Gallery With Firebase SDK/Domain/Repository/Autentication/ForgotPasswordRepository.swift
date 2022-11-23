//
//  ForgotPasswordRepository.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 23/11/22.
//

import Foundation

public struct ForgotPasswordRepository: IForgotPasswordRepository {
    let datasource: IForgotPasswordDataSource
    
    public init(datasource: IForgotPasswordDataSource = ForgotPasswordDataSource(firebaseService: DependencyInjection.get(IFirebaseService.self)!)) {
        self.datasource = datasource
    }
    
    public func execute(withEmail email: Email) async -> Result<Bool, ForgotPasswordErrorUseCase> {
        do {
            let result = try await self.datasource.execute(withEmail: email)
            return .success(result)
        } catch let error as ForgotPasswordErrorDataSource{
            return .failure(error)
        } catch {
            return .failure(ForgotPasswordErrorRepository(message: "Error on ForgotPasswordRepository \(error.localizedDescription)"))
        }
    }
}
