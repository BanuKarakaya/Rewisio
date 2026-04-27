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
    
    func fetchQuiz(urls: [URL], completion: @escaping ([QuizQuestion]) -> Void) {
        let endpoint = "https://shrxdigxvqojyidfducj.functions.supabase.co/generate-questions"
        
        guard let url = URL(string: endpoint) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "urls": urls.map { $0.absoluteString }
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Network error:", error)
                return
            }
            
            guard let data = data else {
                print("No data")
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(QuizResponse.self, from: data)
                
                DispatchQueue.main.async {
                    completion(decoded.questions)
                }
                
            } catch {
                print("Decoding error:", error)
                print(String(data: data, encoding: .utf8) ?? "")
            }
            
        }.resume()
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    func articleAtIndex(index: Int) -> SharedCore.ArticlesDemoEntity {
        let article = articles[index]
        return article
    }
    
    func updateCardActions() {
        delegate?.updateCardUI()
        
        let articleURLs = urls.compactMap { URL(string: $0) }
        fetchQuiz(urls: articleURLs) { questions in
            print("Quiz Questions:")
            
            questions.forEach { question in
                print(question)
            }
        }
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
