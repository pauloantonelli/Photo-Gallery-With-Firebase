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
    var photoList: Array<UIImage> = []
    
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
        //        Task {
        //            await self.getImageList()
        //        }
        for _ in 0...25 {
            let image = UIImage(named: "mock-image")!
            self.photoList.append(image.resize(to: self.sizePattern))
        }
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
                    self.photoList.append(safeImage.resize(to: self.sizePattern))
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
    func goToDetailPage(withImage image: UIImage) -> Void {
        self.performSegue(withIdentifier: Constant.goFromGalleryToGalleryDetail, sender: nil)
    }
}
extension GalleryCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCellCollectionViewCell.reuseIdentifier, for: indexPath) as? GalleryCellCollectionViewCell {
            customCell.updatePhoto(withPhoto: self.photoList[indexPath.row])
            cell = customCell
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let image: UIImage = self.photoList[indexPath.row]
        self.goToDetailPage(withImage: image)
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

