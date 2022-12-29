//
//  KeyboardDismiss.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 27/12/22.
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
