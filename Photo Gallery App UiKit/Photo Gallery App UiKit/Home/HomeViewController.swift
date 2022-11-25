//
//  HomeViewController.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 15/11/22.
//

import UIKit
import Photo_Gallery_With_Firebase_SDK

enum MediaSource {
    case camera
    case gallery
}
class HomeViewController: UIViewController {
    var firebaseService: IFirebaseService!
    var openCameraService: IOpenCameraService!
    var openGalleryService: IOpenGalleryService!
    var saveMediaUseCase: ISaveMediaUseCase!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var cameraButtonView: UIView!
    @IBOutlet weak var galleryButtonView: UIView!
    var activityIndicator: UIActivityIndicatorView!
    var mediaSource: MediaSource = .camera
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firebaseService = DependencyInjection.get(IFirebaseService.self)
        self.openCameraService = DependencyInjection.get(IOpenCameraService.self)
        self.openGalleryService = DependencyInjection.get(IOpenGalleryService.self)
        self.saveMediaUseCase = DependencyInjection.get(ISaveMediaUseCase.self)
        self.setup()
    }
   
    @IBAction func CameraButton(_ sender: UIButton) {
        self.openCamera()
    }
    
    @IBAction func GalleryButton(_ sender: UIButton) {
        self.openGallery()
    }
    
    @IBAction func goToGallery(_ sender: Any) {
        self.performSegue(withIdentifier: Constant.goFromHomeToGallery, sender: self)
    }
}
extension HomeViewController {
    func saveImage(image: UIImage) async -> Void {
        self.showLoading(source: self.mediaSource)
        do {
            let uid = UUID()
            let user: User = self.firebaseService.user
            let result = try await self.saveMediaUseCase.execute(fileName: "user-id-\(user.id)-photo-id-\(uid.uuidString)", image: image).get()
            self.showAlert(message: "Photo Saved") { alertAction in
                self.hideLoading()
                print("Save: \(result)")
            }
        } catch let error as SaveMediaErrorUseCase {
            self.showAlert(message: "Photo not Saved! Try Again") { alertAction in
                self.hideLoading()
                print("SaveMediaErrorUseCase: \(error)")
            }
        } catch {
            self.showAlert(message: "Photo not Saved! Try Again") { alertAction in
                self.hideLoading()
                print("Error: \(error)")
            }
        }
    }
}
extension HomeViewController: IOpenCameraServiceDelegate, IOpenGalleryServiceDelegate {
    func updateImage(withImage image: UIImage) -> Void {
        Task {
            await self.saveImage(image: image)
        }
    }
}
extension HomeViewController {
    func setup() -> Void {
        self.openCameraService.delegate = self
        self.openGalleryService.delegate = self
    }
    
    func openCamera() -> Void {
        self.mediaSource = .camera
        let camera = self.openCameraService.execute()
        self.present(camera, animated: true)
    }
    
    func openGallery() -> Void {
        self.mediaSource = .gallery
        let gallery = self.openGalleryService.execute()
        self.present(gallery, animated: true)
    }
    
    func showAlert(title: String = "Image Save", message: String, actionTitle: String = "Done", completion: ((UIAlertAction) -> Void)?) -> Void {
        let alert = AlertService.alert(title: title, message: message, actionTitle: actionTitle, completion: completion)
        self.present(alert, animated: true)
    }
    
    func enableButton() -> Void {
        self.cameraButton.isEnabled = true
        self.galleryButton.isEnabled = true
    }
    
    func disableButton() -> Void {
        self.cameraButton.isEnabled = false
        self.galleryButton.isEnabled = false
    }
}
extension HomeViewController {
    // MARK: Loading
    func showLoading(source: MediaSource) {
        self.disableButton()
        if (self.activityIndicator == nil) {
            self.activityIndicator = self.createActivityIndicator()
        }
        if source == .camera {
            self.showLoadSpinning(buttonView: self.cameraButtonView, button: self.cameraButton)
        }
        if source == .gallery {
            self.showLoadSpinning(buttonView: self.galleryButtonView, button: self.galleryButton)
        }
    }

    func hideLoading() {
        self.enableButton()
        self.activityIndicator.stopAnimating()
    }

    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
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
