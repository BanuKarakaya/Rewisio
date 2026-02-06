//
//  ArticleCell.swift
//  Rewisio
//
//  Created by Banu Karakaya on 7.01.2026.
//

import UIKit

final class ArticleCell: UICollectionViewCell {

    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 16
        articleImage.layer.cornerRadius = 16
        buttonView.layer.cornerRadius = 25
        mainView.layer.cornerRadius = 16
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOpacity = 0.15
        mainView.layer.shadowOffset = CGSize(width: 0, height: 4)
        mainView.layer.shadowRadius = 8
        self.clipsToBounds = false
    }
}
