//
//  SignUpView.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 14/12/22.
//

import SwiftUI
import Photo_Gallery_With_Firebase_SDK

struct SignUpView: View {
    var signInViewModel: SignInView.SignInViewModel
    var permissionViewModel: PermissionView.PermissionViewModel
    var galleryViewModel: GalleryView.GalleryViewModel
    var galleryDetailViewModel: GalleryDetailView.GalleryDetailViewModel
    var homeViewModel: HomeView.HomeViewModel
    @ObservedObject var signUpViewModel: SignUpViewModel
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var showAlert: Bool = false
    @State private var selectionScreen: NavigationEnum?
    @FocusState var emailFieldIsFocused: Bool
    @FocusState var passwordFieldIsFocused: Bool
    @FocusState var passwordConfirmFieldIsFocused: Bool
    
    init(
        signUpViewModel: ISignUpViewModel,
        signInViewModel: ISignInViewModel,
        permissionViewModel: IPermissionViewModel,
        homeViewModel: IHomeViewModel,
        galleryViewModel: IGalleryViewModel,
        galleryDetailViewModel: IGalleryDetailViewModel
    ) {
        self.signUpViewModel = signUpViewModel as! SignUpView.SignUpViewModel
        self.signInViewModel = signInViewModel as! SignInView.SignInViewModel
        self.permissionViewModel = permissionViewModel as! PermissionView.PermissionViewModel
        self.galleryViewModel = galleryViewModel as! GalleryView.GalleryViewModel
        self.galleryDetailViewModel = galleryDetailViewModel as! GalleryDetailView.GalleryDetailViewModel
        self.homeViewModel = homeViewModel as! HomeView.HomeViewModel
        self.emailFieldIsFocused = false
        self.passwordFieldIsFocused = false
        self.passwordConfirmFieldIsFocused = false
    }
    
    var body: some View {
        VStack {
            Spacer()
            Image("swift-firebase")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(
                    minWidth: 0.0,
                    maxWidth: .infinity,
                    minHeight: 0.0,
                    maxHeight: 150.0
                )
            Text("Create your Account")
                .fontWeight(.bold)
                .font(.title3)
                .foregroundColor(.black.opacity(0.7))
                .frame(
                    minWidth: 0.0,
                    maxWidth: .infinity,
                    alignment: .leading
                )
            TextField(
                "Email",
                text: $email
            )
            .focused($emailFieldIsFocused)
            .onChange(of: self.email) { _ in }
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.emailAddress)
            .padding(.bottom, 20.0)
            Group {
                SecureField(
                    "Password",
                    text: $password
                )
                .focused($passwordFieldIsFocused)
                .onChange(of: self.password) { _ in }
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 20.0)
                SecureField(
                    "Confirm Password",
                    text: $confirmPassword
                )
                .focused($passwordConfirmFieldIsFocused)
                .onChange(of: self.confirmPassword) { _ in }
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 20.0)
            }
            if self.signUpViewModel.isLoading == true {
                LoadingView()
            } else {
                NavigationLink(
                    destination: PermissionView(
                        permissionViewModel: self.permissionViewModel,
                        homeViewModel: self.homeViewModel,
                        galleryViewModel: self.galleryViewModel,
                        galleryDetailViewModel: self.galleryDetailViewModel
                    ),
                    tag: NavigationEnum.permissionView,
                    selection: self.$selectionScreen
                ) {
                    Button("Sign Up", action: {
                        let passwordEqual = self.signUpViewModel.verifyEqualPassword(
                            password: self.password,
                            repassword: self.confirmPassword
                        )
                        if passwordEqual {
                            self.resetFocusField()
                            let email: Email = Email(email: self.email)
                            let password: Password = Password(password: self.password)
                            self.signUpViewModel.signUp(email: email, password: password)
                        }
                    })
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
            }
            Spacer()
            HStack {
                Text("Have an account?")
                    .foregroundColor(.black.opacity(0.7))
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
                    Button("Sign In", action: self.goToSignInPage)
                        .foregroundColor(Color("ButtonBackgroundColor"))
                        .background(.white)
                }
            }
            .padding(.bottom, 30.0)
        }
        .padding(.horizontal, 20.0)
        .onChange(of: self.signUpViewModel.canGoToPermissionPage) { status in
            if status == true {
                self.goToPermissionPage()
            }
        }
        .onReceive(
            NotificationCenter.default.publisher(
                for: self.signUpViewModel.showAlertConstant
            )) { status in
                self.showAlert = status.object as! Bool
            }
            .alert(isPresented: self.$showAlert) {
                return self.signUpViewModel.alert
            }
    }
    
    func goToSignInPage() -> Void {
        self.selectionScreen = NavigationEnum.signInView
    }
    
    func goToPermissionPage() -> Void {
        self.selectionScreen = NavigationEnum.permissionView
    }
    
    func resetFocusField() -> Void {
        self.emailFieldIsFocused = false
        self.passwordFieldIsFocused = false
        self.passwordConfirmFieldIsFocused = false
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(
            signUpViewModel: SignUpView.SignUpViewModel(),
            signInViewModel: SignInView.SignInViewModel(),
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
