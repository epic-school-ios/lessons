//
//  ImageCollectionViewCell.swift
//  TableAndCollectionView
//
//  Created by Denis on 22.03.2022.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: ImageCollectionViewCell.self)
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var heartImageView: UIImageView!
    
    var isChosen = false {
        didSet {
            heartImageView.alpha = isChosen ? 1 : 0.3
        }
    }
    
    func configure(image: UIImage) {
        mainImageView.image = image
        mainImageView.clipsToBounds = true
        mainImageView.layer.cornerRadius = 6
        heartImageView.alpha = 0.3
    }
}
