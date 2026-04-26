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
    var datesArray: [Dates] { get }
    var articleCount: Int { get }
    var selectedDate: Date? { get }
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
    var date: Date?
    var dates: [Dates] = []
    
    init(delegate: ArticlesViewModelDelegate?) {
        self.delegate = delegate
    }
    
    func fetchArticles(date: Date) {
        let context = CoreDataStack.shared.context
        let fetchRequest: NSFetchRequest<ArticlesDemoEntity> = ArticlesDemoEntity.fetchRequest()
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        fetchRequest.predicate = NSPredicate(
            format: "articleDate >= %@ AND articleDate < %@",
            startOfDay as NSDate,
            endOfDay as NSDate
        )
        
        do {
            articles = try context.fetch(fetchRequest)
            print(articles)
        } catch {
            print("Failed to fetch diaries: \(error)")
        }
        delegate?.reloadData()
    }
    
    func fetchDates() {
        let calendar = Calendar.current
        let today = Date()
        
        for i in -2...2 {
            if let newDate = calendar.date(byAdding: .day, value: i, to: today) {
                dates.append(Dates(date: newDate, isSelected: false))
                delegate?.reloadData()
            }
        }
        dates[2].isSelected = true
    }
}

extension ArticlesViewModel: ArticlesViewModelProtocol {
    var datesArray: [Dates] {
        return dates
    }
    
    var selectedDate: Date? {
        if let date = date {
            return date
        }
        return date
    }
    
    func viewDidLoad() {
        delegate?.prepareUI()
        delegate?.prepareCollectionView()
        fetchArticles(date: Date())
        fetchDates()
    }
    
    var articleCount: Int {
        articles.count
    }
    
    func articlesAtIndex(index: Int) -> SharedCore.ArticlesDemoEntity {
        let article = articles[index]
        return article
    }
}

extension ArticlesViewModel: DateCellDelegate {
    func didSelectDate(index: Int) {
        let selectedDate: Date
        
        selectedDate = dates[index].date
        for i in 0 ..< dates.count {
            dates[i].isSelected = false
        }
        dates[index].isSelected = true
        fetchArticles(date: selectedDate)
    }
}
