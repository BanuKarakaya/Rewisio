//
//  HomeViewModel.swift
//  Rewisio
//
//  Created by Banu Karakaya on 4.01.2026.
//

import Foundation
import SharedCore
import CoreData

protocol HomeViewModelProtocol {
    var articleCount: Int { get }
    func viewDidLoad()
    func updateCardActions()
    func articleAtIndex(index: Int) -> ArticlesDemoEntity
}

protocol HomeViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func prepareUI()
    func updateCardUI()
    func reloadData()
}

final class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
    private var articles: [ArticlesDemoEntity] = []
    var urls: [String] = []
    
    init(delegate: HomeViewModelDelegate?) {
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
    
    func fetchArticlesForToday() {
        let context = CoreDataStack.shared.context
        let fetchRequest: NSFetchRequest<ArticlesDemoEntity> = ArticlesDemoEntity.fetchRequest()
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        fetchRequest.predicate = NSPredicate(
            format: "articleDate >= %@ AND articleDate < %@",
            startOfDay as NSDate,
            endOfDay as NSDate
        )
        
        do {
            articles = try context.fetch(fetchRequest)
            // URL'leri güvenli şekilde topla
            urls = articles.compactMap { $0.articleUrl }.filter { !$0.isEmpty }
            print("📚 Fetched \(articles.count) articles for today")
            print("🔗 Collected URLs: \(urls)")
        } catch {
            print("❌ Failed to fetch articles: \(error)")
        }
        delegate?.reloadData()
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    func articleAtIndex(index: Int) -> SharedCore.ArticlesDemoEntity {
        let article = articles[index]
        return article
    }
    
    func updateCardActions() {
        delegate?.updateCardUI()
    }
    
    var articleCount: Int {
        articles.count
    }
    
    func viewDidLoad() {
        delegate?.prepareCollectionView()
        fetchArticlesForToday()
        delegate?.prepareUI()
    }
}
