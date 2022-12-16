//
//  SignInViewController.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 15/11/22.
//

import UIKit
import Photo_Gallery_With_Firebase_SDK

class SignInViewController: UIViewController, UITextFieldDelegate {
    var loginUseCase: ILoginUseCase?
    var forgotPasswordUseCase: IForgotPasswordUseCase?
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signInButtonView: UIView!
    @IBOutlet weak var signInButton: UIButton!
    var activityIndicator: UIActivityIndicatorView!
    var isFocusEmailField: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginUseCase = DependencyInjection.get(ILoginUseCase.self)
        self.forgotPasswordUseCase = DependencyInjection.get(IForgotPasswordUseCase.self)
        self.registerUiTextField()
    }
    
    @IBAction func doSignIn(_ sender: UIButton) {
        Task {
            await self.signIn()
        }
    }
    
    @IBAction func executeForgotPassoword(_ sender: UIButton) {
        Task {
            if self.email.text == nil {
                self.showAlert(message: "Email is Invalid")
                return
            }
            if self.email!.text!.isEmpty {
                self.showAlert(message: "Email is Invalid")
                return
            }
            let email: Email = Email(email: self.email.text!)
            await self.forgotPassword(email: email)
        }
    }
    
    @IBAction func goToSignUp(_ sender: UIButton) {
        self.goToSignUpPage()
    }
}
extension SignInViewController {
    func signIn() async -> Void {
        self.showLoading()
        let credential: Credential = Credential(
            email: Email(email: self.email.text!),
            password: Password(password: self.password.text!)
        )
        do {
            let user: User? = try await self.loginUseCase?.execute(withCredential: credential).get()
            self.hideLoading()
            guard let safeuser = user else {
                self.showAlert(message: "User not found")
                return
            }
            if safeuser.id.isEmpty {
                self.showAlert(message: "User not found")
                return
            }
            self.goToPermissionPage()
        } catch {
            self.hideLoading()
            let e = error as! LoginErrorUseCase
            self.showAlert(message: e.message)
        }
    }
    
    func forgotPassword(email: Email) async -> Void {
        if self.verifyEmail(email: email) == false {
            return
        }
        do {
            let result = try await self.forgotPasswordUseCase?.execute(withEmail: email).get()
            guard let safeResult = result else {
                self.showAlert(title: "Email not sended", message: "Consult your email and try again")
                return
            }
            if safeResult == false {
                self.showAlert(title: "Email not sended", message: "Consult your email and try again")
                return
            }
            self.showAlert(title: "Email is sended", message: "Consult your email to renew your password")
        } catch {
            self.showAlert(title: "Email not sended", message: "Consult your email and try again")
        }
    }
    
    func verifyEmail(email: Email) -> Bool {
        if email.isInvalid {
            self.showAlert(title: "Email is missing", message: "Insert you email on email field")
            return false
        }
        return true
    }
    
    func goToSignUpPage() -> Void {
        self.performSegue(withIdentifier: Constant.goFromSignInToSingUp, sender: self)
    }
    
    func goToPermissionPage() -> Void {
        self.performSegue(withIdentifier: Constant.goFromSignInToPermission, sender: self)
    }
}
extension SignInViewController {
    // MARK: Setup
    func registerUiTextField() -> Void {
        self.email.text = ""
        self.password.text = ""
        self.email.delegate = self
        self.password.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.email {
            self.isFocusEmailField = true
            self.email.resignFirstResponder()
            return true
        }
        if textField == self.password {
            self.isFocusEmailField = false
            self.password.resignFirstResponder()
            return true
        }
        return true
    }
    
    func showAlert(title: String = "Unable to login on account", message: String, actionTitle: String = "I understood") -> Void {
        let alert = AlertService.alert(title: title, message: message, actionTitle: actionTitle) { _ in }
        self.present(alert, animated: true)
    }
}
extension SignInViewController {
    // MARK: Loading
    func showLoading() {
        self.signInButton.setTitle("", for: .normal)
        if (self.activityIndicator == nil) {
            self.activityIndicator = self.createActivityIndicator()
        }
        showSpinning()
    }

    func hideLoading() {
        self.signInButton.setTitle("Sign In", for: .normal)
        self.activityIndicator.stopAnimating()
    }

    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        return activityIndicator
    }

    private func showSpinning() {
        self.signInButton.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.signInButton.addSubview(activityIndicator)
        self.centerActivityIndicatorInButton()
        self.activityIndicator.startAnimating()
    }

    private func centerActivityIndicatorInButton() {
        NSLayoutConstraint.activate([
            self.signInButtonView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.signInButtonView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.signInButton.leadingAnchor.constraint(equalTo: self.signInButtonView.leadingAnchor),
            self.signInButton.trailingAnchor.constraint(equalTo: self.signInButtonView.trailingAnchor),
            self.signInButton.heightAnchor.constraint(equalToConstant: 35),
            self.signInButton.centerYAnchor.constraint(equalTo: self.signInButtonView.centerYAnchor),
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.signInButton.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.signInButton.centerYAnchor),
        ])
    }
}
