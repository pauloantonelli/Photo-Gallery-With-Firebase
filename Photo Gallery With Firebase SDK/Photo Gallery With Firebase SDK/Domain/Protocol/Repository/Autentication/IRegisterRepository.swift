//
//  IRegisterRepository.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 27/10/22.
//

import Foundation

public protocol IRegisterRepository {
    func execute(withCredential credential: Credential) async -> Result<User, RegisterErrorUseCase>
}
