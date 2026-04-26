//
//  ArticleCell.swift
//  Rewisio
//
//  Created by Banu Karakaya on 7.01.2026.
//

import UIKit
import SharedCore

final class ArticleCell: UICollectionViewCell {

    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var articleTitle: UILabel!
    
    @IBAction func articleCellButton(_ sender: Any) {
        viewModel.articleCellButtonTapped()
    }
    
    var viewModel: ArticleCellViewModelProtocol! {
        didSet {
            viewModel.awakeFromNib()
            viewModel.load()
        }
    }
}

extension ArticleCell: ArticleCellViewModelDelegate {
    func configureUI(article: SharedCore.ArticlesDemoEntity) {
        articleTitle.text = article.articleName
        if let data = article.articleImage {
            let image = UIImage(data: data)
            articleImage.image = image
        }
    }
    
    func prepareUI() {
        self.layer.cornerRadius = 16
        articleImage.layer.cornerRadius = 16
        buttonView.layer.cornerRadius = 16
        mainView.layer.cornerRadius = 16
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOpacity = 0.15
        mainView.layer.shadowOffset = CGSize(width: 0, height: 4)
        mainView.layer.shadowRadius = 8
        self.clipsToBounds = false
    }
}
