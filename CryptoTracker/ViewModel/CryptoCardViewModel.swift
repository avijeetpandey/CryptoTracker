//
//  CryptoCardViewModel.swift
//  CryptoTracker
//
//  Created by Avijeet on 23/02/24.
//

import Foundation
import UIKit

// MARK: - CryptoCardViewModel
struct CryptoCardViewModel {
    let title: String
    let subtitle: String
    let isNew: Bool
    let isActive: Bool
    let type: String
    
    var image: UIImage  {
        if self.type == "token" {
            return Asset.token
        } else {
            return Asset.coin
        }
    }
    
    init(title: String, subtitle: String, isNew: Bool, isActive: Bool, type: String) {
        self.title = title
        self.subtitle = subtitle
        self.isNew = isNew
        self.isActive = isActive
        self.type = type
    }
}
