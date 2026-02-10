//
//  ArticlesViewModel.swift
//  Rewisio
//
//  Created by Banu Karakaya on 10.02.2026.
//

import Foundation
import SharedCore
import CoreData

protocol ArticlesViewModelProtocol {
    var articleCount: Int { get }
    func articlesAtIndex(index: Int) -> ArticlesDemoEntity
    func viewDidLoad()
}

protocol ArticlesViewModelDelegate: AnyObject {
    func reloadData()
    func prepareUI()
    func prepareCollectionView()
}

final class ArticlesViewModel {
    weak var delegate: ArticlesViewModelDelegate?
    private var articles: [ArticlesDemoEntity] = []
    
    init(delegate: ArticlesViewModelDelegate?) {
        self.delegate = delegate
    }
    
    func fetchArticles() {
        let context = CoreDataStack.shared.context
        let fetchRequest: NSFetchRequest<ArticlesDemoEntity> = ArticlesDemoEntity.fetchRequest()
        
        do {
            articles = try context.fetch(fetchRequest)
            print(articles)
        } catch {
            print("Failed to fetch diaries: \(error)")
        }
        delegate?.reloadData()
    }
}

extension ArticlesViewModel: ArticlesViewModelProtocol {
    func viewDidLoad() {
        delegate?.prepareUI()
        delegate?.prepareCollectionView()
        fetchArticles()
    }
    
    var articleCount: Int {
        articles.count
    }
    
    func articlesAtIndex(index: Int) -> SharedCore.ArticlesDemoEntity {
        let article = articles[index]
        return article
    }
}
