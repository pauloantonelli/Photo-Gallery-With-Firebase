//
//  IForgotPasswordDataSource.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 23/11/22.
//

import Foundation

public protocol IForgotPasswordDataSource {
    func execute(withEmail email: Email) async throws -> Bool
}
