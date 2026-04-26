//
//  MiniDateCellViewModel.swift
//  Rewisio
//
//  Created by Banu Karakaya on 18.02.2026.
//

import Foundation

protocol MiniDateCellViewModelProtocol {
    func load()
    func awakeFromNib()
}

protocol MiniDateCellViewModelDelegate: AnyObject {
    func setUIForSelected()
    func setUIForUnSelected()
    func configureCell(date: Date?)
}

final class MiniDateCellViewModel {
    weak var delegate: MiniDateCellViewModelDelegate?
    var dateText: Date?
    var isSelected: Bool
    
    init(delegate: MiniDateCellViewModelDelegate?, dateText: Date?, isSelected: Bool) {
        self.delegate = delegate
        self.dateText = dateText
        self.isSelected = isSelected
    }
}

extension MiniDateCellViewModel: MiniDateCellViewModelProtocol {
    func load() {
        if let dateText = dateText {
            delegate?.configureCell(date: dateText)
        }
        
        if isSelected {
            delegate?.setUIForSelected()
        } else {
            delegate?.setUIForUnSelected()
        }
    }
    
    func awakeFromNib() {
        delegate?.setUIForUnSelected()
    }
}
