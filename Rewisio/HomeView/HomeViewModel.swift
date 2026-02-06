//
//  HomeViewModel.swift
//  Rewisio
//
//  Created by Banu Karakaya on 4.01.2026.
//

import Foundation

protocol HomeViewModelProtocol {
    var articleCount: Int { get }
    func viewDidLoad()
    func updateCardActions()
}

protocol HomeViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func prepareUI()
    func updateCardUI()
}

final class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
    private var articles = ["banu", "latif", "atçı", "a", "k", "l", "d"]
    
    init(delegate: HomeViewModelDelegate?) {
        self.delegate = delegate
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    func updateCardActions() {
        delegate?.updateCardUI()
    }
    
    var articleCount: Int {
        articles.count
    }
    
    func viewDidLoad() {
        delegate?.prepareCollectionView()
        delegate?.prepareUI()
    }
}
