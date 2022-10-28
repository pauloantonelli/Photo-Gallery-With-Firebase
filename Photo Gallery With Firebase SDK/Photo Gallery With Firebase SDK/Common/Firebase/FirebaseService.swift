//
//  Firebase.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 25/10/22.
//

import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class FirebaseService {
    var user: User = User()
    var shared: FirebaseService {
        let result = FirebaseService()
        return result
    }
    var authState: AuthStateDidChangeListenerHandle!
    
    init() {
        self.initFirebase()
        self.initListenerUserState()
    }
    
    func initFirebase() -> Void {
        FirebaseApp.configure()
    }
    
    func login(email: String, password: String, completion: @escaping (User?) -> Void) -> Void {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if error != nil {
                completion(nil)
            }
          guard let strongSelf = self else { return }
            let user: User = User(id: authResult?.user.uid ?? "", username: authResult?.user.displayName ?? "", photoUrl: authResult?.user.photoURL ?? URL(string: "")!, credential: Credential(email: Email(email: email)))
            strongSelf.updateUser(user: user)
            completion(user)
        }
    }
    
    func register(email: String, password: String, completion: @escaping (User?) -> Void) -> Void {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if error != nil {
                completion(nil)
            }
            guard let strongSelf = self else { return }
            let user: User = User(id: authResult?.user.uid ?? "", username: authResult?.user.displayName ?? "", photoUrl: authResult?.user.photoURL ?? URL(string: "")!, credential: Credential(email: Email(email: email)))
            strongSelf.updateUser(user: user)
            completion(user)
        }
    }
    
    func initListenerUserState() -> Void {
        self.authState = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if user == nil {
                completion(nil)
            }
            guard let strongSelf = self else { return }
            let user: User = User(id: authResult?.user.uid ?? "", username: authResult?.user.displayName ?? "", photoUrl: authResult?.user.photoURL ?? URL(string: "")!, credential: Credential(email: Email(email: email)))
            strongSelf.updateUser(user: user)
            completion(user)
        }
    }
    
    func disposeListenerLoginState() -> Void {
        Auth.auth().removeStateDidChangeListener(self.authState)
    }
    
    func updateUser(user: User) -> Void {
        self.user = user
    }
}
