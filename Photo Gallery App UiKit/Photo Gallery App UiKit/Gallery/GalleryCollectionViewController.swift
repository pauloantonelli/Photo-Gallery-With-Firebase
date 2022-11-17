//
//  GalleryCollectionViewController.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 15/11/22.
//

import UIKit

class GalleryCollectionViewController: UICollectionViewController {
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    var photoList: Array<UIImage> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initPhotoList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView!.register(GalleryCellCollectionViewCell.self, forCellWithReuseIdentifier: Constant.reuseIdentifier)
    }
    
    func initPhotoList() -> Void {
        for item in 0...10 {
            let image = UIImage(systemName: "pencil")!
            self.photoList.append(image)
        }
        print(self.photoList.count)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.reuseIdentifier, for: indexPath) as? GalleryCellCollectionViewCell {
            customCell.updatePhoto(withPhoto: self.photoList[indexPath.row])
            cell = customCell
        }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("photo escolhida: \(self.photoList[indexPath.row])")
    }
}
