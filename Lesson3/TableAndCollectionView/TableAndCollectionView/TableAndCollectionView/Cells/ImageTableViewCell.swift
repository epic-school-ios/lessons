//
//  ImageTableViewCell.swift
//  TableAndCollectionView
//
//  Created by Denis on 22.03.2022.
//

import UIKit

final class ImageTableViewCell: UITableViewCell {
    
    var onButtonTap: (() -> Void)?
    
    @IBOutlet private var countLabel: UILabel!
    var likesCount = (1...100).randomElement()!
    
    static let reuseIdentifier = String(describing: ImageTableViewCell.self)
    
    @IBOutlet private var mainImageView: UIImageView!
    @IBOutlet private var heartImageView: UIImageView!
    
    var isChosen = false {
        didSet {
            if isChosen {
                likesCount += 1
            } else {
                likesCount -= 1
            }
            countLabel.text = "\(likesCount)"
            heartImageView.alpha = isChosen ? 1 : 0.3
        }
    }
    
    func configure(image: UIImage) {
        countLabel.text = "\(likesCount)"
        mainImageView.clipsToBounds = true
        mainImageView.layer.cornerRadius = 8
        mainImageView.image = image
        heartImageView.alpha = 0.3
        selectionStyle = .none
    }
    
    func update(isChosen: Bool) {
        
    }
    
    @IBAction func buttonDidTap(_ sender: UIButton) {
        onButtonTap?()
    }
}
