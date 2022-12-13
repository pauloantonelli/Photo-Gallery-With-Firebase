//
//  GalleryHeaderCollectionReusableView.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 09/12/22.
//

import UIKit

class GalleryHeaderCollectionReusableView: UICollectionReusableView {
    static let reuseIdentifier = "gallery-collection-header"
    static var segueToHome: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func backToHome(_ sender: UIButton) {
        if GalleryHeaderCollectionReusableView.segueToHome != nil {
            GalleryHeaderCollectionReusableView.segueToHome!()
        }
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "GalleryHeaderCollectionReusableView", bundle: Bundle.main)
    }
    
    override func layoutSubviews() -> Void {
        super.layoutSubviews()
    }
}
