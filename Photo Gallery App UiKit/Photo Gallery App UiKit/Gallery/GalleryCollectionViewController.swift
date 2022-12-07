//
//  GalleryCollectionViewController.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 15/11/22.
//

import UIKit
import Photo_Gallery_With_Firebase_SDK

class GalleryCollectionViewController: UICollectionViewController {
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    var firebaseStorageService: IFirebaseStorageService!
    var getMediaListUrlUseCase: IGetMediaListUrlUseCase!
    let sizePattern: CGSize = CGSize(width: 120, height: 120)
    var photoList: Array<GalleryImageModel> = []
    var galleryImageModel: GalleryImageModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firebaseStorageService = DependencyInjection.get(IFirebaseStorageService.self)
        self.getMediaListUrlUseCase = DependencyInjection.get(IGetMediaListUrlUseCase.self)
        self.initPhotoList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupCollectionView()
    }
    
    func initPhotoList() -> Void {
        Task {
            await self.getImageList()
        }
//        for item in 0...1 {
//            let id = String(item)
//            let image = UIImage(named: "mock-image")!
//            self.photoList.append(GalleryImageModel(id: id, image: image.resize(to: self.sizePattern)))
//        }
        self.galleryCollectionView.reloadData()
    }
    
   
}
extension GalleryCollectionViewController {
    func getImageList() async -> Void {
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
                    self.galleryCollectionView.reloadData()
                }
            }
        } catch let error as GetMediaListUrlErrorUseCase {
            print("GetMediaListUrlErrorUseCase error \(error.message)")
        } catch {
            print("getImageList error \(error.localizedDescription)")
        }
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
            galleyDetailViewController.onDismiss = { status in
                self.initPhotoList()
            }
        }
    }
}
extension GalleryCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCellCollectionViewCell.reuseIdentifier, for: indexPath) as? GalleryCellCollectionViewCell {
            customCell.updatePhoto(withPhoto: self.photoList[indexPath.row].image)
            cell = customCell
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let galleryImageModel: GalleryImageModel = self.photoList[indexPath.row]
        self.goToDetailPage(withGalleryImageModel: galleryImageModel)
    }
}
extension GalleryCollectionViewController: UICollectionViewDelegateFlowLayout {
    func setupCollectionView() -> Void {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15.0, left: 10.0, bottom: 15.0, right: 10.0)
        layout.itemSize = self.sizePattern
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 10.0
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.register(GalleryCellCollectionViewCell.nib(), forCellWithReuseIdentifier: GalleryCellCollectionViewCell.reuseIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.sizePattern
    }
}

