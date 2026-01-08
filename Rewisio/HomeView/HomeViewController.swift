//
//  HomeViewController.swift
//  Rewisio
//
//  Created by Banu Karakaya on 4.01.2026.
//

import UIKit

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
    
    private lazy var viewModel: HomeViewModelProtocol = HomeViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: ArticleCell.self, indexPath: indexPath)
        return cell
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 345, height: 85)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func prepareUI() {
        articleCollectionView.isScrollEnabled = false
        startTestButton.layer.cornerRadius = 16
        quizView.layer.cornerRadius = 16
        trophyView.layer.cornerRadius = 16
        articleSavedView.layer.cornerRadius = 16
        testPassedView.layer.cornerRadius = 16
        testPassedImage.layer.cornerRadius = 16
        articleSavedImage.layer.cornerRadius = 16
        articleCollectionViewHeight.constant = CGFloat((viewModel.articleCount) * 85)
    }
    
    func prepareCollectionView() {
        articleCollectionView.delegate = self
        articleCollectionView.dataSource = self
        articleCollectionView.register(cellType: ArticleCell.self)
    }
}
