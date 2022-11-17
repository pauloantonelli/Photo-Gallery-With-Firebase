//
//  OnboardingViewController.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 15/11/22.
//

import UIKit

class OnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goToSignIn(_ sender: UIButton) {
        self.performSegue(withIdentifier: Constant.goToSignIn, sender: self)
    }
    
    @IBAction func goToSignUp(_ sender: UIButton) {
        self.performSegue(withIdentifier: Constant.goToSignUp, sender: self)
    }
}
