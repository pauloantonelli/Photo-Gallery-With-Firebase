//
//  Photo_Gallery_App_SwiftUIApp.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 13/12/22.
//

import SwiftUI
import Photo_Gallery_With_Firebase_SDK

@main
struct Photo_Gallery_App_SwiftUIApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: self.scenePhase) { (scenePhase) in
            switch scenePhase {
            case .active:
                print("scene is now active!")
            case .inactive:
                print("scene is now inactive!")
            case .background:
                print("scene is now in the background!")
            @unknown default:
                print("scene in unknown state")
            }
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        self.initServiceDependency()
        self.initUseCaseDependecy()
        self.initModelDependency()
        return true
    }
}
extension AppDelegate {
    func initServiceDependency() -> Void {
        DependencyInjection.register(type: IFirebaseService.self, instance: FirebaseService())
        DependencyInjection.register(type: IFirebaseStorageService.self, instance: FirebaseStorageService())
        DependencyInjection.register(type: IMediaPermissionService.self, instance: MediaPermissionService())
        DependencyInjection.register(type: IOpenCameraService.self, instance: OpenCameraService())
        DependencyInjection.register(type: IOpenGalleryService.self, instance: OpenGalleryService())
        DependencyInjection.register(type: IMediaFileService.self, instance: MediaFileService())
    }
}
extension AppDelegate {
    func initUseCaseDependecy() -> Void {
        DependencyInjection.register(type: IRegisterUseCase.self, instance: RegisterUseCase())
        DependencyInjection.register(type: ILoginUseCase.self, instance: LoginUseCase())
        DependencyInjection.register(type: IForgotPasswordUseCase.self, instance: ForgotPasswordUseCase())
        DependencyInjection.register(type: ICameraPermissionUseCase.self, instance: CameraPermissionUseCase())
        DependencyInjection.register(type: IGalleryPermissionUseCase.self, instance: GalleryPermissionUseCase())
        DependencyInjection.register(type: ISaveMediaUseCase.self, instance: SaveMediaUseCase())
        DependencyInjection.register(type: IGetMediaListUrlUseCase.self, instance: GetMediaListUrlUseCase())
        DependencyInjection.register(type: IGetMediaUrlUseCase.self, instance: GetMediaUrlUseCase())
        DependencyInjection.register(type: IDeleteMediaUseCase.self, instance: DeleteMediaUseCase())
    }
}
extension AppDelegate {
    func initModelDependency() -> Void {
        DependencyInjection.register(type: ISignInViewModel.self, instance: SignInView.SignInViewModel())
        DependencyInjection.register(type: ISignUpViewModel.self, instance: SignUpView.SignUpViewModel())
        DependencyInjection.register(type: IPermissionViewModel.self, instance: PermissionView.PermissionViewModel(
            mediaPermissionService: DependencyInjection.get(IMediaPermissionService.self),
            cameraPermissionUseCase: DependencyInjection.get(ICameraPermissionUseCase.self),
            galleryPermissionUseCase: DependencyInjection.get(IGalleryPermissionUseCase.self)
        ))
        DependencyInjection.register(type: IHomeViewModel.self, instance: HomeView.HomeViewModel(
            firebaseService: DependencyInjection.get(IFirebaseService.self)!,
            openCameraService: DependencyInjection.get(IOpenCameraService.self)!,
            openGalleryService: DependencyInjection.get(IOpenGalleryService.self)!,
            saveMediaUseCase: DependencyInjection.get(ISaveMediaUseCase.self)!
        ))
        DependencyInjection.register(type: IGalleryViewModel.self, instance: GalleryView.GalleryViewModel(
            firebaseStorageService: DependencyInjection.get(IFirebaseStorageService.self)!,
            getMediaListUrlUseCase: DependencyInjection.get(IGetMediaListUrlUseCase.self)!)
        )
        DependencyInjection.register(type: IGalleryDetailViewModel.self, instance: GalleryDetailView.GalleryDetailViewModel(
            deleteMediaUseCase: DependencyInjection.get(IDeleteMediaUseCase.self)!
        ))
    }
}
