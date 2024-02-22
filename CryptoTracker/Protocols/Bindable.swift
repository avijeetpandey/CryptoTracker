//
//  Bindable.swift
//  CryptoTracker
//
//  Created by Avijeet on 22/02/24.
//

import Foundation
import UIKit

// MARK: - Bindable Protocol
protocol Bindable {
    associatedtype ViewModel
    
    // binds viewModel data with the view
    func bind(to viewModel: ViewModel)
}
