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
    
    // To store the copy of existing data in order to avoid extra api call in case of other filters
    var copyOfCurrencyViewModel: [CryptoCardViewModel]?
    
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
    
    func refresh() {
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
        self.copyOfCurrencyViewModel = currenciesVM
    }
}

// MARK: - ViewModel Filters
extension HomeViewModel {
    func filter(by filterType: FilterType) {
        switch filterType {
        case .activeCoins:
            handleActiveCoins()
        case .newCrypto:
            handleNewCrypto()
        case .onlyCoins:
            handleOnlyCoins()
        case .onlyTokens:
            handleOnlyToken()
        case .reset:
            handleReset()
        }
    }
    
    
    // filters only the active coins
    func handleActiveCoins() {
        let copyOfData = copyOfCurrencyViewModel
        
        
        let filteredData = copyOfData?.filter({ viewModel in
            return viewModel.isActive == true
        })

        self.currenciesViewModel = filteredData
    }
    
    // filters only new crypto coins
    func handleNewCrypto() {
        let copyOfData = copyOfCurrencyViewModel
        
        
        let filteredData = copyOfData?.filter({ viewModel in
            return viewModel.isNew == true
        })
        
        
        self.currenciesViewModel = filteredData
    }
    
    // filters only coins
    func handleOnlyCoins() {
        let copyOfData = copyOfCurrencyViewModel
        
        
        let filteredData = copyOfData?.filter({ viewModel in
            return viewModel.type == "coin"
        })
        
        
        self.currenciesViewModel = filteredData
    }
    
    // filters only token
    func handleOnlyToken() {
        let copyOfData = copyOfCurrencyViewModel
        
        
        let filteredData = copyOfData?.filter({ viewModel in
            return viewModel.type == "token"
        })
        
        
        self.currenciesViewModel = filteredData
    }
    
    func handleReset() {
        self.currenciesViewModel = copyOfCurrencyViewModel
    }
    
    func search(symbolName: String) {
        let copyOfData = copyOfCurrencyViewModel
        
        let filteredData = copyOfData?.filter({ viewModel in
            return viewModel.subtitle == symbolName
        })
        
        self.currenciesViewModel = filteredData
    }
}
