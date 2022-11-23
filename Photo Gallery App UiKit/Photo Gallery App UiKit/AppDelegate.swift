//
//  AppDelegate.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 04/11/22.
//

import UIKit
import IQKeyboardManagerSwift
import Photo_Gallery_With_Firebase_SDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.initApplicationDependecy()
        self.initIQKeyboardManager()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
extension AppDelegate {
    func initApplicationDependecy() -> Void {
        DependencyInjection.register(type: IFirebaseService.self, instance: FirebaseService())
        DependencyInjection.register(type: IRegisterUseCase.self, instance: RegisterUseCase())
        DependencyInjection.register(type: ILoginUseCase.self, instance: LoginUseCase())
        DependencyInjection.register(type: IForgotPasswordUseCase.self, instance: ForgotPasswordUseCase())
    }
    
    func initIQKeyboardManager() -> Void {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
}
