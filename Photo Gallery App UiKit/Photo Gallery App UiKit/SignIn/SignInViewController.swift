//
//  SignInViewController.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 15/11/22.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToPermission(_ sender: UIButton) {
        self.performSegue(withIdentifier: Constant.goFromSignInToPermission, sender: self)
    }
    
    @IBAction func executeForgotPassoword(_ sender: UIButton) {
        print("executeForgotPassoword")
    }
    
    @IBAction func goToSignUp(_ sender: UIButton) {
        self.performSegue(withIdentifier: Constant.goFromSignInToSingUp, sender: self)
    }
}
