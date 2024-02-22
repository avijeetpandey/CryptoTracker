//
//  HomeViewController+Extensions.swift
//  CryptoTracker
//
//  Created by Avijeet on 23/02/24.
//

import Foundation
import UIKit

// MARK: - UITableView Delegates
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currenciesViewModel?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoCardView.reuseIdentifier) as? CryptoCardView else { return UITableViewCell() }
        guard let currenciesViewModel = viewModel.currenciesViewModel else { return UITableViewCell() }
        cell.bind(to: currenciesViewModel[indexPath.item])
        return cell
    }
}

// MARK: - UITextField Delegates
extension HomeViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(search), userInfo: nil, repeats: false)
    }
    
    @objc func search() {
        if let searchText = searchField.text, !searchText.isEmpty {
            viewModel.search(symbolName: searchText)
        } else {
            viewModel.handleReset()
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

