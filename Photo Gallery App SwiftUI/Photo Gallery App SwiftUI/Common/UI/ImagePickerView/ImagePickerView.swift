//
//  ImagePickerView.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 20/12/22.
//

import UIKit
import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    @ObservedObject var homeViewModel: HomeView.HomeViewModel
    @Binding var showCameraPicker: Bool
    @Binding var showGalleryPicker: Bool
    @Binding var image: Image?
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        if self.showCameraPicker == true {
            return self.homeViewModel.openCamera()
        }
        return self.homeViewModel.openGallery()
    }
}
