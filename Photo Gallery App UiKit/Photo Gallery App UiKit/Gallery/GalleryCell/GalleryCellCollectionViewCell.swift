//
//  GalleryCellCollectionViewCell.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 15/11/22.
//

import UIKit

class GalleryCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updatePhoto(withPhoto image: UIImage) -> Void {
        self.photoImage.image = image
    }
}
