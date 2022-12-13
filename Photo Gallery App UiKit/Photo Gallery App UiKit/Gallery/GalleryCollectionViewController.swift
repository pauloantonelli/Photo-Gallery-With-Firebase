//
//  GalleryCollectionViewController.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 15/11/22.
//

import UIKit
import Photo_Gallery_With_Firebase_SDK

class GalleryCollectionViewController: UIViewController {
    let galleryCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var firebaseStorageService: IFirebaseStorageService!
    var getMediaListUrlUseCase: IGetMediaListUrlUseCase!
    var sizePattern: CGSize = CGSize(width: 120.0, height: 120.0)
    var photoList: Array<GalleryImageModel> = []
    var galleryImageModel: GalleryImageModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firebaseStorageService = DependencyInjection.get(IFirebaseStorageService.self)
        self.getMediaListUrlUseCase = DependencyInjection.get(IGetMediaListUrlUseCase.self)
        self.sizePattern = CGSize(width: (self.view.frame.size.width / 3) - 3, height: (self.view.frame.size.width / 3) - 3)
        self.galleryCollectionView.delegate = self
        self.galleryCollectionView.dataSource = self
        self.view.addSubview(self.galleryCollectionView)
        self.registerView()
        self.initPhotoList()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.galleryCollectionView.frame = self.view.bounds
    }
    
    func initPhotoList() -> Void {
        Task {
            await self.getImageList(completion: { status in
                if status == true {
                    self.galleryCollectionView.reloadData()
                }
            })
        }
    }
    
    func backToHome(_ sender: UIButton) {
        self.performSegue(withIdentifier: Constant.goFromGalleryToHome, sender: self)
    }
}
extension GalleryCollectionViewController {
    func getImageList(completion: @escaping (Bool) -> Void) async -> Void {
        do {
            let urlList = try await self.getMediaListUrlUseCase.execute().get()
            urlList.forEach { url in
                self.firebaseStorageService.download(withUrl: url) { image in
                    guard let safeImage = image else {
                        return
                    }
                    let id = url.absoluteString
                    let image: UIImage = safeImage.resize(to: self.sizePattern)
                    self.photoList.append(GalleryImageModel(id: id, image: image))
                    if self.photoList.count == urlList.count {
                        completion(true)
                    }
                    completion(false)
                }
            }
        } catch let error as GetMediaListUrlErrorUseCase {
            print("GetMediaListUrlErrorUseCase error \(error.message)")
        } catch {
            print("getImageList error \(error.localizedDescription)")
        }
    }
    
    func deletePhotoListItem(indexImage: Int) -> Void {
        let indexPath: IndexPath = IndexPath(item: indexImage, section: 0)
        self.photoList.remove(at: indexImage)
        self.galleryCollectionView.deleteItems(at: [indexPath])
    }
}

extension GalleryCollectionViewController {
    func goToDetailPage(withGalleryImageModel model: GalleryImageModel) -> Void {
        self.galleryImageModel = model
        self.performSegue(withIdentifier: Constant.goFromGalleryToGalleryDetail, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.goFromGalleryToGalleryDetail {
            let galleyDetailViewController = segue.destination as! GalleyDetailViewController
            galleyDetailViewController.galleryImageModel = self.galleryImageModel
            galleyDetailViewController.onDismiss = { status, imageIndex in
                self.deletePhotoListItem(indexImage: imageIndex)
            }
        }
    }
}
extension GalleryCollectionViewController: UICollectionViewDelegate {
    func registerView() -> Void {
        self.galleryCollectionView.register(GalleryCellCollectionViewCell.nib(), forCellWithReuseIdentifier: GalleryCellCollectionViewCell.reuseIdentifier)
        self.galleryCollectionView.register(GalleryHeaderCollectionReusableView.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GalleryHeaderCollectionReusableView.reuseIdentifier)
        GalleryHeaderCollectionReusableView.segueToHome = {
            self.performSegue(withIdentifier: Constant.goFromGalleryToHome, sender: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            return UICollectionReusableView()
        }
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: GalleryHeaderCollectionReusableView.reuseIdentifier, for: indexPath)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        var galleryImageModel: GalleryImageModel = self.photoList[indexPath.row]
        galleryImageModel.imageIndex = indexPath.row
        self.goToDetailPage(withGalleryImageModel: galleryImageModel)
    }
}
extension GalleryCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCellCollectionViewCell.reuseIdentifier, for: indexPath) as? GalleryCellCollectionViewCell {
            customCell.updatePhoto(withPhoto: self.photoList[indexPath.row].image)
            cell = customCell
        }
        return cell
    }
}
extension GalleryCollectionViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let size = CGSize(width: self.view.frame.width, height: 50)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20.0, left: 1.0, bottom: 1.0, right: 1.0)
    }
}
extension GalleryCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.sizePattern
    }
}
