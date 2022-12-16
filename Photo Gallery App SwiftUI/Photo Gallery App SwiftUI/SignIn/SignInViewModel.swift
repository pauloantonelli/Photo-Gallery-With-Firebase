//
//  SignInViewModel.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 16/12/22.
//

import Foundation
import Photo_Gallery_With_Firebase_SDK
import SwiftUI

protocol ISignInViewModel {
    func signIn(email: Email, password: Password) async -> Void
    func forgotPassword(email: Email) async -> Void
    func goToSignUpPage() -> Void
    func goToPermissionPage() -> Void
    func validateEmail(email: Email) -> Bool
    func showLoading() -> Void
    func hideLoading() -> Void
    func showAlert(title: String, message: String, actionTitle: String) -> Void
    func executeSignIn(email: Email, password: Password) async -> Void
    func executeForgotPassword(email: Email) async -> Void
}
extension SignInView {
    class SignInViewModel: ISignInViewModel {
        let showAlertConstant: NSNotification.Name = NSNotification.Name("alert")
        var loginUseCase: ILoginUseCase?
        var forgotPasswordUseCase: IForgotPasswordUseCase?
        var email: String = ""
        var password: String = ""
        var isLoading: Bool = false
        var alert: Alert = Alert(
            title: Text(""),
            message: Text(""),
            dismissButton: .default(Text(""))
        )
        
        init() {
            self.loginUseCase = DependencyInjection.get(ILoginUseCase.self)
            self.forgotPasswordUseCase = DependencyInjection.get(IForgotPasswordUseCase.self)
        }
        
        func signIn(email: Email, password: Password) async {
            await self.executeSignIn(email: email, password: password)
        }
        
        func forgotPassword(email: Email) async {
            await self.executeForgotPassword(email: email)
        }
        
        func goToSignUpPage() -> Void {
           
        }
        
        func goToPermissionPage() -> Void {
            
        }
        
        func validateEmail(email: Email) -> Bool {
            if email.isInvalid {
                self.showAlert(title: "Email is missing", message: "Insert you email on email field")
                return false
            }
            return true
        }
        
        func validatePassword(password: Password) -> Bool {
            if password.isInvalid {
                self.showAlert(title: "Password is missing", message: "Insert your password on the field")
                return false
            }
            return true
        }
        
        func showLoading() -> Void {
            self.isLoading = true
        }
        
        func hideLoading() -> Void {
            self.isLoading = false
        }
        
        func showAlert(title: String = "Unable to login on account", message: String, actionTitle: String = "I understood") -> Void {
            let alert: Alert = Alert(
                title: Text(title),
                message: Text(message),
                dismissButton: .default(Text(actionTitle))
            )
            self.alert = alert
            self.emitAlertStatus(status: true)
        }
        
        func emitAlertStatus(status: Bool) -> Void {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: self.showAlertConstant, object: status)
            }
        }
        
        func executeSignIn(email: Email, password: Password) async -> Void {
            self.showLoading()
            let credential: Credential = Credential(
                email: email,
                password: password
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
        
        func executeForgotPassword(email: Email) async -> Void {
            if self.validateEmail(email: email) == false {
                return
            }
            self.showLoading()
            do {
                let result = try await self.forgotPasswordUseCase?.execute(withEmail: email).get()
                self.hideLoading()
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
                self.hideLoading()
                self.showAlert(title: "Email not sended", message: "Consult your email and try again")
            }
        }
    }
}
