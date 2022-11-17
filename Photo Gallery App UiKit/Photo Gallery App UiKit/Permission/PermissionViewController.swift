//
//  PermissionViewController.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 15/11/22.
//

import UIKit

class PermissionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func grantPermission(_ sender: UIButton) {
        self.goToHome()
    }
    
    @IBAction func deniPermission(_ sender: Any) {
        self.goToHome()
    }
    
    func goToHome() -> Void {
        self.performSegue(withIdentifier: Constant.goFromPermissionToHome, sender: self)
    }
}
