//
//  ILoginRepository.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 27/10/22.
//

import Foundation

protocol ILoginRepository {
    func execute(withCredential credential: Credential) async -> Result<User, LoginError>
}
