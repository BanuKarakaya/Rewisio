//
//  HomeViewController.swift
//  Rewisio
//
//  Created by Banu Karakaya on 4.01.2026.
//

import UIKit
import SharedCore

final class HomeViewController: UIViewController {

    @IBOutlet weak var quizView: UIView!
    @IBOutlet weak var trophyView: UIView!
    @IBOutlet weak var articleSavedView: UIView!
    @IBOutlet weak var testPassedView: UIView!
    @IBOutlet weak var startTestButton: UIButton!
    @IBOutlet weak var testPassedImage: UIImageView!
    @IBOutlet weak var articleSavedImage: UIImageView!
    @IBOutlet weak var articleCollectionView: UICollectionView!
    @IBOutlet weak var articleCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var quizCardTitle: UILabel!
    @IBOutlet weak var quizCardSubTitle: UILabel!
    @IBOutlet weak var quizCardView: UIView!
    @IBOutlet weak var quizCardImage: UIImageView!
    @IBOutlet weak var articleSavedCount: UILabel!
    
    enum CardState {
        case ganeratorQuiz
        case startQuiz
    }
    
    private var cardState: CardState = .ganeratorQuiz
    private lazy var viewModel: HomeViewModelProtocol = HomeViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults(suiteName: "group.com.banu.rewisio")
        print(defaults?.string(forKey: "sharedURL") ?? "banu")
        viewModel.viewDidLoad()
    }
    
    @IBAction func StartTestButtonTapped(_ sender: Any) {
        viewModel.updateCardActions()
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.articleCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: ArticleCell.self, indexPath: indexPath)
        let article = viewModel.articleAtIndex(index: indexPath.item)
        let cellViewModel = ArticleCellViewModel(delegate: cell, article: article)
        cell.viewModel = cellViewModel
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 345, height: 410)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 20, left: 0, bottom: 20, right: 0)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func reloadData() {
        articleCollectionView.reloadData()
    }
    
    func updateCardUI() {
        switch cardState {
            
        case .ganeratorQuiz:
            cardState = .startQuiz
            quizCardView.backgroundColor = UIColor.systemPurple
            quizCardTitle.text = "Data Science Quiz"
            quizCardSubTitle.text = "15 Questions"
            startTestButton.setTitle("Start Test", for: .normal)
            startTestButton.isEnabled = true
        case .startQuiz:
            cardState = .ganeratorQuiz
            let quizView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QuizViewController")
            navigationController?.pushViewController(quizView, animated: true)
            quizCardView.backgroundColor = UIColor.systemOrange
            quizCardTitle.text = "AI Quiz Generator"
            quizCardSubTitle.text = "From your saved articles"
            startTestButton.setTitle("Generate Quiz", for: .normal)
            startTestButton.isEnabled = true
            
        }
    }
    
    func prepareUI() {
        articleCollectionView.isScrollEnabled = false
        startTestButton.layer.cornerRadius = 16
        quizView.layer.cornerRadius = 16
        trophyView.layer.cornerRadius = 16
        articleSavedView.layer.cornerRadius = 16
        testPassedView.layer.cornerRadius = 16
        testPassedImage.layer.cornerRadius = 16
        articleSavedImage.layer.cornerRadius = 16
        articleSavedCount.text = "\(viewModel.articleCount)"
        articleCollectionViewHeight.constant = CGFloat((viewModel.articleCount) * 115)
        
    }
    
    func prepareCollectionView() {
        articleCollectionView.delegate = self
        articleCollectionView.dataSource = self
        articleCollectionView.register(cellType: ArticleCell.self)
        articleCollectionView.register(cellType: AddArticleCell.self)
    }
}
