//
//  ArticlesViewController.swift
//  Rewisio
//
//  Created by Banu Karakaya on 8.01.2026.
//

import UIKit

final class ArticlesViewController: UIViewController {

    @IBOutlet weak var articlesCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        articlesCollectionView.dataSource = self
        articlesCollectionView.delegate = self
        articlesCollectionView.register(cellType: ArticleCell.self)
        articlesCollectionView.register(cellType: DateCell.self)
    }
    

}

extension ArticlesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            1
        } else {
            7
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeCell(cellType: DateCell.self, indexPath: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeCell(cellType: ArticleCell.self, indexPath: indexPath)
            return cell
        }
    }
}

extension ArticlesViewController: UICollectionViewDelegate {
    
}

extension ArticlesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 00 {
            .init(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            .init(top: 20, left: 16.5, bottom: 20, right: 16.5)
        }
    }
}

