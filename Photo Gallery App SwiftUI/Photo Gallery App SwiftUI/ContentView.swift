//
//  ContentView.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 22/12/22.
//

import SwiftUI
import Photo_Gallery_With_Firebase_SDK

struct ContentView: View {
    @State var dependencyInjectionInitialized: Bool = false
    
    var body: some View {
        VStack {
            if self.dependencyInjectionInitialized == false {
                    LaunchScreen()
            } else {
                NavigationView {
                    OnboardingView(
                        signInViewModel: DependencyInjection.get(ISignInViewModel.self)!,
                        signUpViewModel: DependencyInjection.get(ISignUpViewModel.self)!,
                        permissionViewModel: DependencyInjection.get(IPermissionViewModel.self)!,
                        homeViewModel: DependencyInjection.get(IHomeViewModel.self)!,
                        galleryViewModel: DependencyInjection.get(IGalleryViewModel.self)!,
                        galleryDetailViewModel: DependencyInjection.get(IGalleryDetailViewModel.self)!
                    )
                }
            }
        }
        .onLoad {
            self.dependencyInjectionInitialized = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
