//
//  OnboardingView.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 13/12/22.
//

import SwiftUI
import Photo_Gallery_With_Firebase_SDK

struct OnboardingView: View {
    var signInViewModel: SignInView.SignInViewModel
    var signUpViewModel: SignUpView.SignUpViewModel
    var permissionViewModel: PermissionView.PermissionViewModel
    var galleryViewModel: GalleryView.GalleryViewModel
    var galleryDetailViewModel: GalleryDetailView.GalleryDetailViewModel
    var homeViewModel: HomeView.HomeViewModel
    @State private var selectionScreen: NavigationEnum?
    
    init(
        signInViewModel: ISignInViewModel,
        signUpViewModel: ISignUpViewModel,
        permissionViewModel: IPermissionViewModel,
        homeViewModel: IHomeViewModel,
        galleryViewModel: IGalleryViewModel,
        galleryDetailViewModel: IGalleryDetailViewModel
    ) {
        self.signInViewModel = signInViewModel as! SignInView.SignInViewModel
        self.signUpViewModel = signUpViewModel as! SignUpView.SignUpViewModel
        self.permissionViewModel = permissionViewModel as! PermissionView.PermissionViewModel
        self.homeViewModel = homeViewModel as! HomeView.HomeViewModel
        self.galleryViewModel = galleryViewModel as! GalleryView.GalleryViewModel
        self.galleryDetailViewModel = galleryDetailViewModel as! GalleryDetailView.GalleryDetailViewModel
    }
    
    var body: some View {
        VStack {
            VStack {
                Image("swift-firebase")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("Hello !")
                    .fontWeight(.bold)
                    .font(.title)
                Spacer()
                Text("Best place to save your stories and share experiences whever you want")
                    .fontWeight(.thin)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                Spacer()                
                NavigationLink(
                    destination: SignInView(
                        signInViewModel: self.signInViewModel,
                        signUpViewModel: self.signUpViewModel,
                        permissionViewModel: self.permissionViewModel,
                        homeViewModel: self.homeViewModel,
                        galleryViewModel: self.galleryViewModel,
                        galleryDetailViewModel: self.galleryDetailViewModel
                    ),
                    tag: NavigationEnum.signInView,
                    selection: self.$selectionScreen
                ) {
                    Button("Sign In", action: self.signIn)
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            maxHeight: 35.0
                        )
                        .foregroundColor(.white)
                        .background(Color("ButtonBackgroundColor"))
                        .cornerRadius(5.0)
                        .padding(.bottom, 10.0)
                }
                NavigationLink(
                    destination: SignUpView(
                        signUpViewModel: self.signUpViewModel,
                        signInViewModel: self.signInViewModel,
                        permissionViewModel: self.permissionViewModel,
                        homeViewModel: self.homeViewModel,
                        galleryViewModel: self.galleryViewModel,
                        galleryDetailViewModel: self.galleryDetailViewModel
                    ),
                    tag: NavigationEnum.signUpView,
                    selection: self.$selectionScreen
                ) {
                    Button("Sign Up", action: self.signUp)
                        .frame(
                            minWidth: 0.0,
                            maxWidth: .infinity,
                            maxHeight: 35.0
                        )
                        .foregroundColor(.white)
                        .background(Color("ButtonBackgroundColor"))
                        .cornerRadius(5.0)
                }
            }
            .padding(.horizontal, 20.0)
            Spacer(minLength: 50.0)
            HStack(
                alignment: .center,
                spacing: 0.0
            ) {
                Text("made by:")
                    .foregroundColor(.white)
                    .padding(.leading, 10.0)
                Spacer()
                Image("zoominitcode-logo")
                    .resizable()
                    .frame(
                        minWidth: 0.0,
                        maxWidth: 100.0,
                        minHeight: 0.0,
                        maxHeight: 50.0
                    )
                Spacer(minLength: 100.0)
            }
            .frame(
                minWidth: 0.0,
                maxWidth: .infinity,
                minHeight: 0.0,
                maxHeight: 52.0
            )
            .background(Color.gray)
            .padding(.all, 20.0)
            .navigationBarBackButtonHidden(true)
        }
    }
    
    func signIn() -> Void {
        self.selectionScreen = NavigationEnum.signInView
    }
    
    func signUp() -> Void {
        self.selectionScreen = NavigationEnum.signUpView
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(
            signInViewModel: SignInView.SignInViewModel(),
            signUpViewModel: SignUpView.SignUpViewModel(),
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
