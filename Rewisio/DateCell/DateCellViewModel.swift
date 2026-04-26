//
//  DateCellViewModel.swift
//  Rewisio
//
//  Created by Banu Karakaya on 18.02.2026.
//

import Foundation

protocol DateCellDelegate: AnyObject {
    func didSelectDate(index: Int)
}

protocol DateCellViewModelProtocol {
    var dateCount: Int { get }
    func awakeFromNib()
    func dateAtIndex(index: Int) -> Dates
    func didSelectItemAt(index: Int)
}

protocol DateCellViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func reloadData()
}

final class DateCellViewModel {
    weak var delegate: DateCellViewModelDelegate?
    weak var dateDelegate: DateCellDelegate?
    var selectedDate: Date?
    var dates: [Dates] = []
    
    init(delegate: DateCellViewModelDelegate?, dateDelegate: DateCellDelegate?, selectedDate: Date?, dates: [Dates]) {
        self.delegate = delegate
        self.dateDelegate = dateDelegate
        self.selectedDate = selectedDate
        self.dates = dates
    }
}

struct Dates {
    let date: Date
    var isSelected: Bool
}

extension DateCellViewModel: DateCellViewModelProtocol {
    func didSelectItemAt(index: Int) {
        delegate?.reloadData()
        dateDelegate?.didSelectDate(index: index)
    }
    
    var dateCount: Int {
        dates.count
    }
    
    func dateAtIndex(index: Int) -> Dates {
        let date = dates[index]
        return date
    }
    
    func awakeFromNib() {
        delegate?.prepareCollectionView()
    }
}
