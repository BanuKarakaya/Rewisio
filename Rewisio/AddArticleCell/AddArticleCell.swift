//
//  AddArticleCell.swift
//  Rewisio
//
//  Created by Banu Karakaya on 9.01.2026.
//

import UIKit

final class AddArticleCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var exploreButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 60
        self.layer.cornerRadius = 16
        mainView.layer.cornerRadius = 16
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOpacity = 0.25
        mainView.layer.shadowOffset = CGSize(width: 0, height: 4)
        mainView.layer.shadowRadius = 8
        self.clipsToBounds = false
        exploreButton.layer.cornerRadius = 8
    }
}
