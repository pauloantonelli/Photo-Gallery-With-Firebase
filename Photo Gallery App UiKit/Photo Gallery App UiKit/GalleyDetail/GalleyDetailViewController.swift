//
//  GalleyDetailViewController.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 30/11/22.
//

import Foundation
import UIKit
import Photo_Gallery_With_Firebase_SDK
import SwiftUI

class GalleyDetailViewController: UIViewController, UIViewControllerTransitioningDelegate {
    var deleteMediaUseCase: IDeleteMediaUseCase!
    var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageDetailView: UIView!
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var deleteImageButtonView: UIView!
    @IBOutlet weak var deleteImageButton: UIButton!
    var galleryImageModel: GalleryImageModel?
    var onDismiss: ((Bool, Int) -> Void)?
    
    override func viewDidLoad() {
        self.deleteMediaUseCase = DependencyInjection.get(IDeleteMediaUseCase.self)
        if let safeImage = self.galleryImageModel {
            self.imageDetail.image = safeImage.image
        }
        transitioningDelegate = self
    }
    
    @IBAction func deleteImage(_ sender: UIButton) {
        if self.galleryImageModel == nil { return }
        Task {
            self.showLoading()
            let imageName: String = self.galleryImageModel!.id.extractImageNameFromString()
            let imageExtension: String = self.galleryImageModel!.id.extractImageFormatFromString() ?? "jpeg"
            let result = await self.executeDeleteMedia(imageName: imageName, imageExtension: imageExtension)
            self.hideLoading()
            if result == false {
                self.showAlert(message: "Could not delete file", completion: { _ in })
                return
            }
            self.dismiss(animated: true)
            self.onDismiss!(true, self.galleryImageModel?.imageIndex ?? 0)
        }
         
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("BackToCollection")
        return nil
    }
}
extension GalleyDetailViewController {
    func executeDeleteMedia(imageName: String, imageExtension: String) async -> Bool {
        do {
            let result: Bool = try await self.deleteMediaUseCase.execute(imageName: imageName, imageExtension: imageExtension).get()
            return result
        } catch let error as DeleteMediaErrorUseCase {
            print("executeDeleteMedia: \(error.message)")
            self.showAlert(message: error.message, completion: { _ in })
            return false
        } catch {
            print("executeDeleteMedia: \(error.localizedDescription)")
            self.showAlert(message: error.localizedDescription, completion: { _ in })
            return false
        }
    }
}
extension GalleyDetailViewController {
    func enableButton() -> Void {
        self.deleteImageButton.isEnabled = true
        self.deleteImageButton.setTitle("Deletar", for: .normal)
    }
    
    func disableButton() -> Void {
        self.deleteImageButton.isEnabled = false
        self.deleteImageButton.setTitle("", for: .disabled)
    }
    
    func showAlert(title: String = "Image Delete", message: String, actionTitle: String = "Done", completion: ((UIAlertAction) -> Void)?) -> Void {
        let alert = AlertService.alert(title: title, message: message, actionTitle: actionTitle, completion: completion)
        self.present(alert, animated: true)
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
        activityIndicator.color = UIColor(named: "BackgroundColor")
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
