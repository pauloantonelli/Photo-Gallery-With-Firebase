//
//  GalleyDetailViewController.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 30/11/22.
//

import Foundation
import UIKit
import Photo_Gallery_With_Firebase_SDK

class GalleyDetailViewController: UIViewController {
    var deleteMediaUseCase: IDeleteMediaUseCase!
    var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageDetailView: UIView!
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var deleteImageButtonView: UIView!
    @IBOutlet weak var deleteImageButton: UIButton!
    
    override func viewDidLoad() {
        self.deleteMediaUseCase = DependencyInjection.get(IDeleteMediaUseCase.self)
    }
    
    @IBAction func deleteImage(_ sender: UIButton) {
//        self.dismiss(animated: true)
        self.showLoading()
        Timer.scheduledTimer(timeInterval: 5.0)
    }
}
extension GalleyDetailViewController {
    func enableButton() -> Void {
        self.deleteImageButton.isEnabled = true
        self.deleteImageButton.setTitle("Deletar", for: .normal)
    }
    
    func disableButton() -> Void {
        self.deleteImageButton.isEnabled = false
        self.deleteImageButton.setTitle(nil, for: .disabled)
    }
}
extension GalleyDetailViewController {
    // MARK: Loading
    func showLoading() {
        self.disableButton()
        if (self.activityIndicator == nil) {
            self.activityIndicator = self.createActivityIndicator()
        }
        self.showLoadSpinning(buttonView: self.deleteImageButtonView, button: self.deleteImageButton)
    }

    func hideLoading() {
        self.enableButton()
        self.activityIndicator.stopAnimating()
    }

    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .purple
        return activityIndicator
    }

    private func showLoadSpinning(buttonView: UIView, button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(activityIndicator)
        self.centerActivityIndicatorInButton(buttonView: buttonView, button: button)
        self.activityIndicator.startAnimating()
    }

    private func centerActivityIndicatorInButton(buttonView: UIView, button: UIButton) {
        NSLayoutConstraint.activate([
            buttonView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            button.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor),
            button.heightAnchor.constraint(equalTo: buttonView.heightAnchor),
            button.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor),
            self.activityIndicator.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: button.centerYAnchor),
        ])
    }
}
