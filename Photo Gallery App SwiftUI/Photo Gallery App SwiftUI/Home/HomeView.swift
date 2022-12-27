//
//  HomeView.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 15/12/22.
//

import SwiftUI
import Photo_Gallery_With_Firebase_SDK

struct HomeView: View {
    var galleryViewModel: GalleryView.GalleryViewModel
    var galleryDetailViewModel: GalleryDetailView.GalleryDetailViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    @State var showAlert: Bool = false
    @State var showCameraPicker: Bool = false
    @State var showGalleryPicker: Bool = false
    @State var image: Image?
    @State private var selectionScreen: NavigationEnum?
    
    init(homeViewModel: IHomeViewModel, galleryViewModel: IGalleryViewModel, galleryDetailViewModel: IGalleryDetailViewModel) {
        self.homeViewModel = homeViewModel as! HomeViewModel
        self.galleryViewModel = galleryViewModel as! GalleryView.GalleryViewModel
        self.galleryDetailViewModel = galleryDetailViewModel as! GalleryDetailView.GalleryDetailViewModel
    }
    
    var body: some View {
        VStack {
            Spacer(minLength: 50.0)
            Text("Choose a send method")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 20.0)
            Text("Choose camera to take an photo")
                .font(.title3)
                .fontWeight(.thin).foregroundColor(.black.opacity(0.7))
                .padding(.bottom, 10.0)
            Text("Choose gallery and pick an photo")
                .font(.title3)
                .fontWeight(.thin).foregroundColor(.black.opacity(0.7))
                .padding(.bottom, 60.0)
            if self.homeViewModel.isLoading == true {
                LoadingView()
            } else {
                HStack(
                    alignment: .center,
                    spacing: 80
                ) {
                    Group {
                        Button(action: {
                            self.openCamera()
                        }) {
                            Image("camera-permission")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .frame(minHeight: 0.0, maxHeight: 100.0)
                        .sheet(isPresented: self.$showCameraPicker) {
                            ImagePickerView(
                                homeViewModel: self.homeViewModel,
                                showCameraPicker: self.$showCameraPicker,
                                showGalleryPicker: self.$showGalleryPicker,
                                image: $image)
                        }
                    }
                    Group {
                        Button(action: {
                            self.openGallery()
                        }) {
                            Image("gallery-permission")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .frame(minHeight: 0.0, maxHeight: 100.0)
                        .sheet(isPresented: self.$showGalleryPicker) {
                            ImagePickerView(
                                homeViewModel: self.homeViewModel,
                                showCameraPicker: self.$showCameraPicker,
                                showGalleryPicker: self.$showGalleryPicker,
                                image: self.$image
                            )
                        }
                    }
                }
            }
            Spacer()
            NavigationLink(
                destination: GalleryView(
                    galleryViewModel: self.galleryViewModel,
                    galleryDetailViewModel: self.galleryDetailViewModel
                ).navigationBarBackButtonHidden(true),
            tag: NavigationEnum.galleryView,
            selection: self.$selectionScreen
            ) {
                Button(action: {self.goToGallery()}) {
                    Image(systemName: "photo.on.rectangle")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                        .padding(.all, 20.0)
                }
                .frame(
                    minWidth: 0.0,
                    maxWidth: 120.0,
                    minHeight: 0.0,
                    maxHeight: 70.0
                )
                .background(Color("LinkColor"))
                .cornerRadius(5.0)
            }
        }.onReceive(NotificationCenter.default.publisher(for: self.homeViewModel.showAlertConstant)) { status in
            self.showAlert = status.object as! Bool
        }
        .alert(isPresented: self.$showAlert) {
            return self.homeViewModel.alert
        }
    }
    
    func openCamera() -> Void {
        self.showCameraPicker = true
        self.showGalleryPicker = false
    }
    
    func openGallery() -> Void {
        self.showCameraPicker = false
        self.showGalleryPicker = true
    }
    
    func goToGallery() -> Void {
        self.selectionScreen = NavigationEnum.galleryView
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            homeViewModel: HomeView.HomeViewModel(
            firebaseService: FirebaseService(),
            openCameraService: OpenCameraService(),
            openGalleryService: OpenGalleryService(),
            saveMediaUseCase: SaveMediaUseCase()),
            galleryViewModel: GalleryView.GalleryViewModel(
                firebaseStorageService: FirebaseStorageService(),
                getMediaListUrlUseCase: GetMediaListUrlUseCase()),
            galleryDetailViewModel: GalleryDetailView.GalleryDetailViewModel(
                deleteMediaUseCase: DeleteMediaUseCase()
            )
        )
    }
}
