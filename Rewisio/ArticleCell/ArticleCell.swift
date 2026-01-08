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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 16
        articleImage.layer.cornerRadius = 16
        buttonView.layer.cornerRadius = 25
        self.layer.borderColor = UIColor.systemGray.withAlphaComponent(0.3).cgColor
    }
}
