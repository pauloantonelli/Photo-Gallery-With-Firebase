//
//  IFirebaseService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 23/11/22.
//

import Foundation

public protocol IFirebaseService {
    var user: User { get }
    var shared: FirebaseService { get }
    var delegate: IFirebaseServiceDelegate? { get set }
    
    func login(email: String, password: String) async throws -> User
    func register(email: String, password: String) async throws -> User
    func signOut() throws -> Bool
    func forgotPassword(withEmail email: String) async throws -> Bool
}
