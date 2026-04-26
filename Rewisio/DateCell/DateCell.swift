//
//  DateCell.swift
//  Rewisio
//
//  Created by Banu Karakaya on 8.01.2026.
//

import UIKit

final class DateCell: UICollectionViewCell {
    
    @IBOutlet weak var dateCollectionView: UICollectionView!
    
    var viewModel: DateCellViewModelProtocol! {
        didSet {
            viewModel.awakeFromNib()
        }
    }
}

extension DateCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.dateCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: MiniDateCell.self, indexPath: indexPath)
        let date = viewModel.dateAtIndex(index: indexPath.item)
        let cellViewModel = MiniDateCellViewModel(delegate: cell, dateText: date.date, isSelected: date.isSelected)
        cell.viewModel = cellViewModel
        return cell
    }
}

extension DateCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(index: indexPath.item)
    }
}

extension DateCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 60, height: 95)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 7.5, left: 15, bottom: 7.5, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
}

extension DateCell: DateCellViewModelDelegate {
    func reloadData() {
        dateCollectionView.reloadData()
    }
    
    func prepareCollectionView() {
        dateCollectionView.dataSource = self
        dateCollectionView.delegate = self
        dateCollectionView.register(cellType: MiniDateCell.self)
    }
}
