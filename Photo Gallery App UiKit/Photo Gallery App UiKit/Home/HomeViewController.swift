//
//  HomeViewController.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 15/11/22.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    @IBAction func CameraButton(_ sender: UIButton) {
    }
    
    @IBAction func GalleryButton(_ sender: UIButton) {
    }
    
    
    @IBAction func goToGallery(_ sender: Any) {
        self.performSegue(withIdentifier: Constant.goFromHomeToGallery, sender: self)
    }
}
