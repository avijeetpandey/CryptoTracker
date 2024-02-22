//
//  UITableView+Extensions.swift
//  CryptoTracker
//
//  Created by Avijeet on 23/02/24.
//

import Foundation
import UIKit

// MARK: - UITableViewCell Extensions
extension UITableViewCell {
    class var reuseIdentifier: String {
        String(describing: self)
    }
}

// MARK: - UITableView Extensions
extension UITableView {
    func registerCellClass<T: UITableViewCell>(_ cellType: T.Type) {
        self.register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
}
