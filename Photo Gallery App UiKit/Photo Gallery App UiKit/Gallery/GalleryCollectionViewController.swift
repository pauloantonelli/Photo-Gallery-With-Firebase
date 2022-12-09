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
        self.galleryCollectionView.register(GalleryHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GalleryHeaderCollectionReusableView.reuseIdentifier)
        self.setupCollectionView()
        self.initPhotoList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.galleryCollectionView.reloadData()
    }
    
    func initPhotoList() -> Void {
        //                Task {
        //                    await self.getImageList(completion: { status in
        //                        print(self.photoList)
        //                    })
        //                }
        self.mockImageWeb()
    }
    
    func mockImageWeb() -> Void {
        let num = Int.random(in: 3...4)
        print("num is \(num)")
        let isPair = num / 2 == 2 ? true : false
        print("isPair: \(isPair)")
        let resolution = isPair == true ? "350" : "150"
        self.photoList = []
        let urlList = [URL(string: "https://via.placeholder.com/\(resolution)"), URL(string: "https://via.placeholder.com/\(resolution)"), URL(string: "https://via.placeholder.com/\(resolution)"), URL(string: "https://via.placeholder.com/\(resolution)"), URL(string: "https://via.placeholder.com/\(resolution)"), URL(string: "https://via.placeholder.com/\(resolution)"), URL(string: "https://via.placeholder.com/\(resolution)"), URL(string: "https://via.placeholder.com/\(resolution)"), URL(string: "https://via.placeholder.com/\(resolution)"), URL(string: "https://via.placeholder.com/\(resolution)"),]
        urlList.forEach { url in
            let data = NSData(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            self.photoList.append(GalleryImageModel(id: url!.absoluteString, image: image!))
        }
    }
    
    @IBAction func backToHome(_ sender: UIButton) {
        self.performSegue(withIdentifier: Constant.goFromGalleryToHome, sender: self)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: GalleryHeaderCollectionReusableView.reuseIdentifier, for: indexPath)
        return header
    }
    
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        switch kind {
//        case UICollectionView.elementKindSectionHeader:
//            self.collectionView.register(GalleryHeaderCollectionReusableView.nib(), forCellWithReuseIdentifier: GalleryHeaderCollectionReusableView.reuseIdentifier)
//            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: GalleryHeaderCollectionReusableView.reuseIdentifier, for: indexPath)
//            headerView.backgroundColor = UIColor.blue;
//            return headerView
//        case UICollectionView.elementKindSectionFooter:
//            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "gallery-collection-footer", for: indexPath as IndexPath)
//            footerView.backgroundColor = UIColor.green;
//            return footerView
//        default:
//            assert(false, "Unexpected element kind")
//        }
//    }
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
        self.collectionView.deleteItems(at: [indexPath])
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
        var galleryImageModel: GalleryImageModel = self.photoList[indexPath.row]
        galleryImageModel.imageIndex = indexPath.row
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
        layout.headerReferenceSize = CGSizeMake(0, 50);
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.register(GalleryCellCollectionViewCell.nib(), forCellWithReuseIdentifier: GalleryCellCollectionViewCell.reuseIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.sizePattern
    }
}

