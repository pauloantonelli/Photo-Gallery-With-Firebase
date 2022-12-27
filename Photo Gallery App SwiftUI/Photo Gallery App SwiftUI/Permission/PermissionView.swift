//
//  PermissionView.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 14/12/22.
//

import SwiftUI
import Photo_Gallery_With_Firebase_SDK

struct PermissionView: View {
    var galleryViewModel: GalleryView.GalleryViewModel
    var galleryDetailViewModel: GalleryDetailView.GalleryDetailViewModel
    var homeViewModel: HomeView.HomeViewModel
    @ObservedObject var permissionViewModel: PermissionViewModel
    @State var showAlert: Bool = false
    @State private var selectionScreen: NavigationEnum?
    
    init(
        permissionViewModel: IPermissionViewModel,
        homeViewModel: IHomeViewModel,
        galleryViewModel: IGalleryViewModel,
        galleryDetailViewModel: IGalleryDetailViewModel
    ) {
        self.permissionViewModel = permissionViewModel as! PermissionViewModel
        self.homeViewModel = homeViewModel as! HomeView.HomeViewModel
        self.galleryViewModel = galleryViewModel as! GalleryView.GalleryViewModel
        self.galleryDetailViewModel = galleryDetailViewModel as! GalleryDetailView.GalleryDetailViewModel
    }
    
    var body: some View {
        VStack {
            Image("permission")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(minHeight: 0.0, maxHeight: 150.0, alignment: .center)
                .padding(.bottom, 20.0)
            Text("Allow your Camera")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.black.opacity(0.7))
                .padding(.bottom, 20.0)
            Text("We will need your camera to give you better experience.")
                .font(.subheadline)
                .fontWeight(.thin)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20.0)
            NavigationLink(
                destination: HomeView(
                    homeViewModel: self.homeViewModel,
                    galleryViewModel: self.galleryViewModel,
                    galleryDetailViewModel: self.galleryDetailViewModel
                ),
                tag: NavigationEnum.homeView,
                selection: self.$selectionScreen
            ) {
                Button(action: {
                    self.permitionState(status: true)
                }) {
                    Text("Sure, I'd Like that")
                        .fontWeight(.bold)
                }
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    maxHeight: 35.0
                )
                .foregroundColor(Color("PermissionButtonLabelColor"))
                .background(Color("PermissionButtonBackgroundColor"))
                .cornerRadius(5.0)
                .padding(.bottom, 10.0)
            }
            Button(action: {
                self.permitionState(status: false)
            }) {
                Text("Not now")
                    .fontWeight(.bold)
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                maxHeight: 35.0
            )
            .foregroundColor(Color("PermissionButtonBackgroundColor"))
            .background(.white)
            .cornerRadius(5.0)
            .padding(.bottom, 10.0)
        }
        .padding(.horizontal, 20.0)
        .onChange(of: self.permissionViewModel.canGoToHomePage) { status in
            if status == true {
                self.goToHomePage()
            }
        }
        .onReceive(
            NotificationCenter.default.publisher(
                for: self.permissionViewModel.showAlertConstant
            )) { status in
                self.showAlert = status.object as! Bool
            }
            .alert(isPresented: self.$showAlert) {
                return self.permissionViewModel.alert
            }
    }
    
    func goToHomePage() -> Void {
        self.selectionScreen = NavigationEnum.homeView
    }
    
    func permitionState(status: Bool) -> Void {
        if status == false {
            self.permissionViewModel.deniPermission()
            return
        }
        self.permissionViewModel.grantPermission()
    }
}

struct PermissionView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionView(
            permissionViewModel: PermissionView.PermissionViewModel(
                mediaPermissionService: MediaPermissionService(),
                cameraPermissionUseCase: CameraPermissionUseCase(),
                galleryPermissionUseCase: GalleryPermissionUseCase()
            ),
            homeViewModel: HomeView.HomeViewModel(
                firebaseService: FirebaseService(),
                openCameraService: OpenCameraService(),
                openGalleryService: OpenGalleryService(),
                saveMediaUseCase: SaveMediaUseCase()
            ),
            galleryViewModel: GalleryView.GalleryViewModel(
                firebaseStorageService: FirebaseStorageService(),
                getMediaListUrlUseCase: GetMediaListUrlUseCase()),
            galleryDetailViewModel: GalleryDetailView.GalleryDetailViewModel(
                deleteMediaUseCase: DeleteMediaUseCase()
            )
        )
    }
}
