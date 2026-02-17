//
//  ArticleCellViewModel.swift
//  Rewisio
//
//  Created by Banu Karakaya on 8.02.2026.
//

import Foundation
import SharedCore

protocol ArticleCellButtonTappedDelegate: AnyObject {
    func articleCellButtonTapped(articleUrl: String)
}

protocol ArticleCellViewModelProtocol {
    func awakeFromNib()
    func load()
    func articleCellButtonTapped()
}

protocol ArticleCellViewModelDelegate: AnyObject {
    func prepareUI()
    func configureUI(article: ArticlesDemoEntity)
}

final class ArticleCellViewModel {
    weak var delegate: ArticleCellViewModelDelegate?
    weak var buttonTappedDelegate: ArticleCellButtonTappedDelegate?
    private var article: ArticlesDemoEntity?
    
    init(delegate: ArticleCellViewModelDelegate?, article: ArticlesDemoEntity?, buttonTappedDelegate: ArticleCellButtonTappedDelegate?) {
        self.delegate = delegate
        self.article = article
        self.buttonTappedDelegate = buttonTappedDelegate
    }
}

extension ArticleCellViewModel: ArticleCellViewModelProtocol {
    func articleCellButtonTapped() {
        buttonTappedDelegate?.articleCellButtonTapped(articleUrl: article?.articleUrl ?? "")
    }
    
    func load() {
        if let article = article {
            delegate?.configureUI(article: article)
        }
    }
    
    func awakeFromNib() {
        delegate?.prepareUI()
    }
}
