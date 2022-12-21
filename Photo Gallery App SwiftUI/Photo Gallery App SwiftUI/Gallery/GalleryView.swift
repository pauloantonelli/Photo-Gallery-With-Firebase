//
//  GalleryView.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 15/12/22.
//

import SwiftUI
import Photo_Gallery_With_Firebase_SDK

struct GalleryView: View {
    @ObservedObject var galleryViewModel: GalleryViewModel
    @ObservedObject var galleryDetailViewModel: GalleryDetailView.GalleryDetailViewModel
    @State var showAlert: Bool = false
    @State private var showSheet = false
    var rowList: Array<GridItem> = []
    
    init(galleryViewModel: IGalleryViewModel, galleryDetailViewModel: IGalleryDetailViewModel) {
        self.galleryViewModel = galleryViewModel as! GalleryView.GalleryViewModel
        self.galleryDetailViewModel = galleryDetailViewModel as!  GalleryDetailView.GalleryDetailViewModel
        self.rowListConfigure()
    }
    
    var body: some View {
        VStack {
            Group {
                HStack {
                    Button(action: {
                        self.backToHome()
                    }) {
                        Text("Back to Home")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                    .padding(.leading, 20.0)
                    Spacer()
                    Image("swift-firebase")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minHeight: 0.0, maxHeight: 50.0)
                        .padding(.trailing, 20.0)
                }
                .background(Color("BackgroundColor"))
                .frame(height: 50.0)
            }
            ScrollView {
                if self.galleryViewModel.isLoading == true {
                    ActivityIndicatorView(color: Color("ButtonBackgroundColor"))
                        .frame(width: 50.0, height: 50.0)
                } else {
                    LazyVGrid(columns: self.rowList, spacing: 10.0) {
                        ForEach(self.galleryViewModel.photoList.indices, id: \.self) { index in
                            Button(action: {
                                self.galleryDetailViewModel.galleryImageModel = self.galleryViewModel.photoList[index]
                                self.showSheet.toggle()
                            }) { self.galleryViewModel.photoList[index].image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                            .sheet(isPresented: $showSheet) {
                                GalleryDetailView(
                                    galleryViewModel: self.galleryViewModel,
                                    galleryDetailViewModel: self.galleryDetailViewModel
                                )
                            }
                        }
                    }}
            }
            .padding(.horizontal, 10.0)
        }
        .onAppear() {
            self.galleryViewModel.loadPhotoList()
        }
        .onReceive(NotificationCenter.default.publisher(for: self.galleryViewModel.showAlertConstant)) { status in
            self.showAlert = status.object as! Bool
        }
        .alert(isPresented: self.$showAlert) {
            return self.galleryViewModel.alert
        }
    }
    
    func backToHome() -> Void {
        print("backToHome")
    }
}
extension GalleryView {
    mutating func rowListConfigure() -> Void {
        for _ in 0...2 {
            self.rowList.append(GridItem(.flexible(minimum: 100.0), spacing: 5.0))
        }
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView(galleryViewModel: GalleryView.GalleryViewModel(
            firebaseStorageService: FirebaseStorageService(),
            getMediaListUrlUseCase: GetMediaListUrlUseCase()),
                    galleryDetailViewModel: GalleryDetailView.GalleryDetailViewModel(
                deleteMediaUseCase: DeleteMediaUseCase()
            )
        )
    }
}
