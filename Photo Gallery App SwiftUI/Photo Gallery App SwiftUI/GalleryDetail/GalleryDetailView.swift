//
//  GalleyDetailView.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 15/12/22.
//

import SwiftUI
import Photo_Gallery_With_Firebase_SDK

struct GalleryDetailView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var galleryViewModel: GalleryView.GalleryViewModel
    @ObservedObject var galleryDetailViewModel: GalleryDetailViewModel
    @State var showAlert: Bool = false
    
    init(galleryViewModel: IGalleryViewModel, galleryDetailViewModel: IGalleryDetailViewModel) {
        self.galleryViewModel = galleryViewModel as! GalleryView.GalleryViewModel
        self.galleryDetailViewModel = galleryDetailViewModel as! GalleryDetailView.GalleryDetailViewModel
    }
    
    var body: some View {
        VStack {
            Spacer()
            self.galleryDetailViewModel.galleryImageModel?.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .padding(.trailing, 20.0)
            Spacer()
            if self.galleryDetailViewModel.isLoading == true {
                ActivityIndicatorView(color: Color("ButtonBackgroundColor"))
                    .frame(width: 50.0, height: 50.0)
            } else {
                Button("Delete", action: self.executeDelete)
                                .frame(
                                    minWidth: 0,
                                    maxWidth: .infinity,
                                    maxHeight: 65.0
                                )
                                .foregroundColor(.white)
                                .background(Color("ButtonBackgroundColor"))
                                .cornerRadius(5.0)
                                .padding(.bottom, 10.0)
            }
        }
        .padding(.horizontal, 20.0)
        .onReceive(NotificationCenter.default.publisher(for: self.galleryDetailViewModel.showAlertConstant)) { status in
            self.showAlert = status.object as! Bool
        }
        .alert(isPresented: self.$showAlert) {
            return self.galleryDetailViewModel.alert
        }
        .onChange(of: self.galleryDetailViewModel.doDismiss) { status in
            if status == false { return }
            if self.galleryDetailViewModel.needDismiss == false { return }
            if self.galleryDetailViewModel.galleryImageModel == nil { return }
            self.galleryViewModel.deletePhotoListItem(
                withPhotoId: self.galleryDetailViewModel.galleryImageModel!.id
            )
            self.dismiss()
        }
    }
    
    func executeDelete() -> Void {
        Task {
            await self.galleryDetailViewModel.deleteImage()
        }
    }
}

struct GalleryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryDetailView(
            galleryViewModel: GalleryView.GalleryViewModel(
                firebaseStorageService: FirebaseStorageService(),
                getMediaListUrlUseCase: GetMediaListUrlUseCase()),
            galleryDetailViewModel: GalleryDetailView.GalleryDetailViewModel(
            deleteMediaUseCase: DeleteMediaUseCase()
        ))
    }
}
