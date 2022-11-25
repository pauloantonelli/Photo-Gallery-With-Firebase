//
//  OnboardingViewController.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 15/11/22.
//

import UIKit
import Photo_Gallery_With_Firebase_SDK

class OnboardingViewController: UIViewController {
    var firebaseService: IFirebaseService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firebaseService = DependencyInjection.get(IFirebaseService.self)
        self.firebaseService.delegate = self
    }
    
    @IBAction func goToSignIn(_ sender: UIButton) {
        self.goToSignInPage()
    }
    
    @IBAction func goToSignUp(_ sender: UIButton) {
        self.goToSignUpPage()
    }
}
extension OnboardingViewController {
    func setup() -> Void {
        let isLogged = self.firebaseService.user.isLogged
        if isLogged {
            self.goToHomePermissionPage()
        }
    }
    
    func goToSignInPage() -> Void {
        self.performSegue(withIdentifier: Constant.goToSignIn, sender: self)
    }
    
    func goToSignUpPage() -> Void {
        self.performSegue(withIdentifier: Constant.goToSignUp, sender: self)
    }
    
    func goToHomePermissionPage() -> Void {
        self.performSegue(withIdentifier: Constant.goFromOnboardingToPermission, sender: self)
    }
}
extension OnboardingViewController: IFirebaseServiceDelegate {
    func updateUser(user: User) {
        self.setup()
    }
}
