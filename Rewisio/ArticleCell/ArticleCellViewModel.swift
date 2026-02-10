//
//  ArticleCellViewModel.swift
//  Rewisio
//
//  Created by Banu Karakaya on 8.02.2026.
//

import Foundation
import SharedCore

protocol ArticleCellViewModelProtocol {
    func awakeFromNib()
    func load()
}

protocol ArticleCellViewModelDelegate: AnyObject {
    func prepareUI()
    func configureUI(article: ArticlesDemoEntity)
}

final class ArticleCellViewModel {
    weak var delegate: ArticleCellViewModelDelegate?
    private var article: ArticlesDemoEntity?
    
    init(delegate: ArticleCellViewModelDelegate?, article: ArticlesDemoEntity?) {
        self.delegate = delegate
        self.article = article
    }
}

extension ArticleCellViewModel: ArticleCellViewModelProtocol {
    func load() {
        if let article = article {
            delegate?.configureUI(article: article)
        }
    }
    
    func awakeFromNib() {
        delegate?.prepareUI()
    }
}
