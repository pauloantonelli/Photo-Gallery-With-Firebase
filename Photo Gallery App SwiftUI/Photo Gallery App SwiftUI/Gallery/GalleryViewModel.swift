//
//  GalleryViewModel.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 20/12/22.
//

import SwiftUI
import Photo_Gallery_With_Firebase_SDK

protocol IGalleryViewModel {
    func loadPhotoList() -> Void
    func getImageList() async -> Void
    func deletePhotoListItem(withPhotoId: String) -> Void
    func showLoading() -> Void
    func hideLoading() -> Void
    func alertAction() -> Void
    func showAlert(title: String, message: String, actionTitle: String) -> Void
    func emitAlertStatus(status: Bool) -> Void
}
extension GalleryView {
    class GalleryViewModel: IGalleryViewModel, ObservableObject {
        let showAlertConstant: NSNotification.Name = NSNotification.Name("GalleryAlert")
        var firebaseStorageService: IFirebaseStorageService
        var getMediaListUrlUseCase: IGetMediaListUrlUseCase
        var sizePattern: CGSize = CGSize(width: 120.0, height: 120.0)
        var galleryImageModel: GalleryImageModel?
        var alert: Alert = Alert(
            title: Text(""),
            message: Text(""),
            dismissButton: .default(Text(""))
        )
        @Published var photoList: Array<GalleryImageModel> = []
        @Published var isLoading: Bool = false
        
        init(firebaseStorageService: IFirebaseStorageService, getMediaListUrlUseCase: IGetMediaListUrlUseCase) {
            self.firebaseStorageService = firebaseStorageService
            self.getMediaListUrlUseCase = getMediaListUrlUseCase
        }
        
        func mock() {
            self.showLoading()
            for _ in 0...100 {
                self.photoList.append(GalleryImageModel(
                    id: UUID().uuidString, image: Image("mock-image")
                ))
            }
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
                self.hideLoading()
            }
        }
        
        func loadPhotoList() -> Void {
            Task {
                await self.getImageList()
            }
        }
        
        func getImageList() async -> Void {
            do {
                self.showLoading()
                self.resetPhotoList()
                let urlList: Array<URL> = try await self.getMediaListUrlUseCase.execute().get()
                urlList.forEach { url in
                    self.firebaseStorageService.download(withUrl: url) { image in
                        guard let safeImage = image else {
                            return
                        }
                        let id = url.absoluteString
                        let uiImage: UIImage = safeImage.resize(to: self.sizePattern)
                        let image: Image = Image(uiImage: uiImage).renderingMode(.original)
                        self.photoList.append(GalleryImageModel(id: id, image: image))                     
                        if self.photoList.count == urlList.count {
                            self.hideLoading()
                        }
                    }
                }
            } catch let error as GetMediaListUrlErrorUseCase {
                self.hideLoading()
                self.showAlert(message: error.message)
                print("GetMediaListUrlErrorUseCase error \(error.message)")
            } catch {
                self.hideLoading()
                self.showAlert(message: error.localizedDescription)
                print("getImageList error \(error.localizedDescription)")
            }
        }
        
        func deletePhotoListItem(withPhotoId: String) -> Void {
            self.photoList.removeAll(where: { $0.id == withPhotoId})
        }
        
        func resetPhotoList() -> Void {
            DispatchQueue.main.async {
                self.photoList = []
            }
        }
        
        func showLoading() -> Void {
            DispatchQueue.main.async {
                self.isLoading = true
            }
        }
        
        func hideLoading() -> Void {
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
        
        func alertAction() -> Void {
            self.loadPhotoList()
        }
        
        func showAlert(title: String = "Photos can't load right now, please try again", message: String, actionTitle: String = "Try Again") -> Void {
            let alert: Alert = Alert(
                title: Text(title),
                message: Text(message),
                dismissButton: .default(
                    Text(actionTitle),
                    action: self.alertAction
                )
            )
            self.alert = alert
            self.emitAlertStatus(status: true)
        }
        
        func emitAlertStatus(status: Bool) -> Void {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: self.showAlertConstant, object: status)
            }
        }
    }
}
