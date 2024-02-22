//
//  HomeViewController.swift
//  CryptoTracker
//
//  Created by Avijeet on 22/02/24.
//

import Foundation
import UIKit

// MARK: - HomeViewController
class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apiManager = NetworkClient.shared
        
        apiManager.sendRequest(urlString: "https://run.mocky.io/v3/ac7d7699-a7f7-488b-9386-90d1a60c4a4b", method: .get) { (response: Result<CryptoCurrenciesModel, NetworkError>) in
            switch response {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
