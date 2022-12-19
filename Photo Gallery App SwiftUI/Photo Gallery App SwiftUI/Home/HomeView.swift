//
//  HomeView.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 15/12/22.
//

import SwiftUI
import Photo_Gallery_With_Firebase_SDK

struct HomeView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    
    init(homeViewModel: IHomeViewModel) {
        self.homeViewModel = homeViewModel as! HomeViewModel
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
            HStack(
                alignment: .center,
                spacing: 80
            ) {
                Button(action: {}) {
                    Image("camera-permission")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(minHeight: 0.0, maxHeight: 100.0)
                Button(action: {}) {
                    Image("gallery-permission")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(minHeight: 0.0, maxHeight: 100.0)
            }
            Spacer()
            Button(action: {}) {
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
    }
    
    func cameraButton() {
        self.homeViewModel.openCamera()
    }
    
    func galleryButton() {
        self.homeViewModel.openGallery()
    }
    
    func goToGallery(_ sender: Any) {
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(homeViewModel: HomeView.HomeViewModel(
            firebaseService: FirebaseService(),
            openCameraService: OpenCameraService(),
            openGalleryService: OpenGalleryService(),
            saveMediaUseCase: SaveMediaUseCase())
        )
    }
}
