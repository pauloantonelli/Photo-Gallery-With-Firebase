//
//  Firebase.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 25/10/22.
//

import FirebaseCore
import FirebaseAuth

public class FirebaseService: IFirebaseService {
    public var user: User = User(id: "")
    public var delegate: IFirebaseServiceDelegate?
    public var shared: FirebaseService {
        let result = FirebaseService()
        return result
    }
    var authState: AuthStateDidChangeListenerHandle!
    
    public init() {
        self.initFirebase()
        self.initListenerUserState()
    }
    
    deinit {
        self.disposeListenerLoginState()
    }
    
    func initFirebase() -> Void {
        FirebaseApp.configure()
    }
    
    public func login(email: String, password: String) async throws -> User {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            let user: User = User(id: authResult.user.uid, username: authResult.user.displayName ?? "", photoUrl: authResult.user.photoURL ?? URL(string: AppConstant.image)!, credential: Credential(email: Email(email: email)))
            self.updateUser(user: user)
            return user
        } catch {
            let user: User = User(id: "")
            return user
        }
    }
    
    public func register(email: String, password: String) async throws -> User {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            let user: User = User(id: authResult.user.uid, username: authResult.user.displayName ?? "", photoUrl: authResult.user.photoURL ?? URL(string: AppConstant.image)!, credential: Credential(email: Email(email: email)))
            self.updateUser(user: user)
            return user
        } catch {
            let user: User = User(id: "")
            return user
        }
    }
    
    public func signOut() throws -> Bool {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            return true
        } catch let signOutError as NSError {
            print("Error sign out: %@", signOutError)
            return false
        }
    }
    
    public func forgotPassword(withEmail email: String) async throws -> Bool {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
            return true
        } catch let forgotPasswordError as NSError {
            print("Error forgot password: %@", forgotPasswordError)
            return false
        }
    }
    
    func initListenerUserState() -> Void {
        self.authState = Auth.auth().addStateDidChangeListener { auth, user in
            guard let safeuser = user else {
                return
            }
            let user: User = User(id: safeuser.uid, username: safeuser.displayName ?? "", photoUrl: safeuser.photoURL ?? URL(string: AppConstant.image)!, credential: Credential(email: Email(email: safeuser.email ?? "")))
            self.updateUser(user: user)
        }
    }
    
    func disposeListenerLoginState() -> Void {
        Auth.auth().removeStateDidChangeListener(self.authState)
    }
    
    func updateUser(user: User) -> Void {
        self.user = user
        self.delegate?.updateUser(user: user)
    }
}
