//
//  SignUpViewController.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 15/11/22.
//

import UIKit
import Photo_Gallery_With_Firebase_SDK

class SignUpViewController: UIViewController, UITextFieldDelegate {
    var registerUseCase: IRegisterUseCase?
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var signUpButtonView: UIView!
    @IBOutlet weak var signUpButton: UIButton!
    var activityIndicator: UIActivityIndicatorView!
    var isFocusEmailField: Bool = false
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerUseCase = DependencyInjection.get(IRegisterUseCase.self)
        self.registerUiTextField()
        self.setupNotification()
    }
    
    @IBAction func doSignUp(_ sender: UIButton) {
        Task {
            await self.signUp()
        }
    }
    
    @IBAction func goToSignIn(_ sender: UIButton) {
        self.performSegue(withIdentifier: Constant.goFromSignUpToSingIn, sender: self)
    }
}
extension SignUpViewController {
    // MARK: Bussiness Rule
    func signUp() async -> Void {
        self.showLoading()
        let credential: Credential = Credential(
            email: Email(email: self.email.text!),
            password: Password(password: self.password.text!)
        )
        do {
            let user: User? = try await self.registerUseCase?.execute(withCredential: credential).get()
            self.hideLoading()
            guard let safeuser = user else {
                self.showAlert(message: "User not created")
                return
            }
            if safeuser.id.isEmpty {
                self.showAlert(message: "User not created")
                return
            }
            self.goToPermission()
        } catch {
            self.hideLoading()
            let e = error as! RegisterErrorUseCase
            self.showAlert(message: e.message)
        }
    }
    
    func goToPermission() -> Void {
           self.performSegue(withIdentifier: Constant.goFromSignUpToPermission, sender: self)
    }
    
    func verifyEqualPassword(password: String, repassword: String) -> Void {
        let result: Bool = password.contains(repassword)
        if result == false {
            self.showAlert(message: "Password are not equal")
        }
    }
}
extension SignUpViewController {
    // MARK: Setup
    func registerUiTextField() -> Void {
        self.email.text = ""
        self.password.text = ""
        self.confirmPassword.text = ""
        self.email.delegate = self
        self.password.delegate = self
        self.confirmPassword.delegate = self
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
        if textField == self.confirmPassword {
            self.isFocusEmailField = false
            self.confirmPassword.resignFirstResponder()
            return true
        }
        return true
    }
    
    func showAlert(title: String = "Unable to create an account", message: String, actionTitle: String = "I understood") -> Void {
        let alert = AlertService.alert(title: title, message: message, actionTitle: actionTitle)
        self.present(alert, animated: true)
    }
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: .main) { [weak self] notification in
                if self?.isFocusEmailField == false {
                    self?.verifyEqualPassword(password: (self?.password!.text!)!, repassword: (self?.confirmPassword!.text!)!)
                }
            }
    }
}
extension SignUpViewController {
    // MARK: Loading
    func showLoading() {
        self.signUpButton.setTitle("", for: .normal)
        if (self.activityIndicator == nil) {
            self.activityIndicator = self.createActivityIndicator()
        }
        showSpinning()
    }

    func hideLoading() {
        self.signUpButton.setTitle("Sign Up", for: .normal)
        self.activityIndicator.stopAnimating()
    }

    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        return activityIndicator
    }

    private func showSpinning() {
        self.signUpButton.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.signUpButton.addSubview(activityIndicator)
        self.centerActivityIndicatorInButton()
        self.activityIndicator.startAnimating()
    }

    private func centerActivityIndicatorInButton() {
        NSLayoutConstraint.activate([
            self.signUpButtonView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.signUpButtonView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.signUpButton.leadingAnchor.constraint(equalTo: self.signUpButtonView.leadingAnchor),
            self.signUpButton.trailingAnchor.constraint(equalTo: self.signUpButtonView.trailingAnchor),
            self.signUpButton.heightAnchor.constraint(equalToConstant: 35),
            self.signUpButton.centerYAnchor.constraint(equalTo: self.signUpButtonView.centerYAnchor),
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.signUpButton.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.signUpButton.centerYAnchor),
        ])
    }
}
