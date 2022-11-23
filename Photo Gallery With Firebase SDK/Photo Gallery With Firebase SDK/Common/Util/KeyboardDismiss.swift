//
//  KeyboardDismiss.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 22/11/22.
//

import UIKit

public extension UIViewController {
    func registerConfirmPasswordDoneDismiss() -> Void {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func hideKeyboard() -> Void {
        self.view.endEditing(true)
    }
}
