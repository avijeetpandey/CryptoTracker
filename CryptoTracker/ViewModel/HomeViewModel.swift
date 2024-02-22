//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Avijeet on 23/02/24.
//

import Foundation

class HomeViewModel {
    // MARK: - Properties
    private let apiManager: NetworkClient
    
    var currenciesViewModel: [CryptoCardViewModel]? {
        didSet {
            didCurrenciesViewModelChanged?(currenciesViewModel)
        }
    }
    
    // MARK: - Listeners
    var didCurrenciesViewModelChanged: (([CryptoCardViewModel]?) -> Void)?
    
    // MARK: - init
    init(apiManager: NetworkClient) {
        self.apiManager = apiManager
    }
    
    // MARK: - Lifecycle
    func viewDidLoaded() {
        getCryptoInfo()
    }
}

// MARK: - API Call
private extension HomeViewModel {
    func getCryptoInfo() {
        apiManager.sendRequest(networkObject: ApiPath.cryptoCurrencyUrl) { [weak self] (response: Result<CryptoCurrenciesModel,NetworkError>) in
            guard let `self` = self else { return }
            switch response {
            case .success(let currenciesViewModel):
                updateCurrenciesViewModel(with: currenciesViewModel)
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Updating viewModel with data
private extension HomeViewModel {
    func updateCurrenciesViewModel(with data: CryptoCurrenciesModel) {
        var currenciesVM: [CryptoCardViewModel] = []
        
        data.cryptoCurrencies.forEach({ currencyInfo in
            
            // generating a single view model for card component
            let currencyVM: CryptoCardViewModel = .init(title: currencyInfo?.name ?? "",
                                                        subtitle: currencyInfo?.symbol ?? "",
                                                        isNew: currencyInfo?.isNew ?? false,
                                                        isActive: currencyInfo?.isActive ?? false,
                                                        type: currencyInfo?.type ?? "")
            
            // appending the view model created in the card element pool
            currenciesVM.append(currencyVM)
        })
        
        self.currenciesViewModel = currenciesVM
    }
}
