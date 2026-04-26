//
//  MiniDateCell.swift
//  Rewisio
//
//  Created by Banu Karakaya on 8.01.2026.
//

import UIKit

class MiniDateCell: UICollectionViewCell {

    @IBOutlet weak var dateString: UILabel!
    @IBOutlet weak var dayString: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var mainView: UIView!
    
    let customColor = UIColor(
        red: 97/255.0,
        green: 95/255.0,
        blue: 249/255.0,
        alpha: 1.0
    )
    
    var viewModel: MiniDateCellViewModelProtocol! {
        didSet {
            viewModel.awakeFromNib()
            viewModel.load()
        }
    }
}

extension MiniDateCell: MiniDateCellViewModelDelegate {
    func setUIForUnSelected() {
        self.layer.cornerRadius = 16
        mainView.backgroundColor = UIColor.white
        dayString.textColor = customColor
        dateString.textColor = customColor
    }
    
    func setUIForSelected() {
        self.layer.cornerRadius = 16
        mainView.backgroundColor = customColor
        dayString.textColor = UIColor.white
        dateString.textColor = UIColor.white
        iconView.tintColor = UIColor.white
    }
    
    func configureCell(date: Date?) {
        
        if let date = date {
            let formatter = DateFormatter()
            
            formatter.dateFormat = "EEE"
            let dayName = formatter.string(from: date)
            
            formatter.dateFormat = "d"
            let dateText = formatter.string(from: date)
            
            dayString.text = dayName
            dateString.text = dateText
        }
    }
}
