//
//  UICollectionViewCell+Extension.swift
//  Movie App
//
//  Created by Latif Atci on 8.09.2025.
//

import UIKit

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
   
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
