//
//  DateCell.swift
//  Rewisio
//
//  Created by Banu Karakaya on 8.01.2026.
//

import UIKit

final class DateCell: UICollectionViewCell {

    @IBOutlet weak var dateCollectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateCollectionView.dataSource = self
        dateCollectionView.delegate = self
        dateCollectionView.register(cellType: MiniDateCell.self)
    }
}

extension DateCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: MiniDateCell.self, indexPath: indexPath)
        return cell
    }
}

extension DateCell: UICollectionViewDelegate {
    
}

extension DateCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 60, height: 95)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 7.5, left: 18, bottom: 7.5, right: 18)
    }
}
