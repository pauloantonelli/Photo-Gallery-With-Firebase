//
//  GalleryDetailViewModel.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 20/12/22.
//

import Foundation
import Photo_Gallery_With_Firebase_SDK
import SwiftUI

protocol IGalleryDetailViewModel {
    func deleteImage() async -> Void
    func executeDeleteMedia(imageName: String, imageExtension: String) async -> Bool
    func updateNeedDismiss(status: Bool) -> Void
    func showLoading() -> Void
    func hideLoading() -> Void
    func alertAction() -> Void
    func showAlert(title: String, message: String, actionTitle: String) -> Void
    func emitAlertStatus(status: Bool) -> Void
}
extension GalleryDetailView {
    class GalleryDetailViewModel: IGalleryDetailViewModel, ObservableObject {
        let showAlertConstant: NSNotification.Name = NSNotification.Name("GalleryDetailAlert")
        var deleteMediaUseCase: IDeleteMediaUseCase
        var galleryImageModel: GalleryImageModel?
        var alert: Alert = Alert(
            title: Text(""),
            message: Text(""),
            dismissButton: .default(Text(""))
        )
        @Published var isLoading: Bool = false
        @Published var needDismiss: Bool = false
        @Published var doDismiss: Bool = false
        
        init(deleteMediaUseCase: IDeleteMediaUseCase) {
            self.deleteMediaUseCase = deleteMediaUseCase
        }
        
        func deleteImage() async -> Void {
            if self.galleryImageModel == nil { return }
            self.showLoading()
            let imageName: String = self.galleryImageModel!.id.extractImageNameFromString()
            let imageExtension: String = self.galleryImageModel!.id.extractImageFormatFromString() ?? "jpeg"
            let result = await self.executeDeleteMedia(imageName: imageName, imageExtension: imageExtension)
            self.hideLoading()
            if result == false {
                self.showAlert(message: "Could not delete file")
                self.updateNeedDismiss(status: false)
                return
            }
            self.updateNeedDismiss(status: true)
        }
        
        func executeDeleteMedia(imageName: String, imageExtension: String) async -> Bool {
            do {
                let result: Bool = try await self.deleteMediaUseCase.execute(imageName: imageName, imageExtension: imageExtension).get()
                return result
            } catch let error as DeleteMediaErrorUseCase {
                print("executeDeleteMedia: \(error.message)")
                self.showAlert(message: error.message)
                return false
            } catch {
                print("executeDeleteMedia: \(error.localizedDescription)")
                self.showAlert(message: error.localizedDescription)
                return false
            }
        }
        
        func updateNeedDismiss(status: Bool) -> Void {
            DispatchQueue.main.async {
                self.needDismiss = status
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
            self.doDismiss.toggle()
        }
        
        func showAlert(title: String = "Image Delete", message: String, actionTitle: String = "Done") -> Void {
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
