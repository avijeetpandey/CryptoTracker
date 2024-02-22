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
    
    // MARK: - Instance creation
    static func controller() -> HomeViewController {
        let viewModel = HomeViewModel(apiManager: NetworkClient.shared)
        let vc = HomeViewController(viewModel: viewModel)
        return vc
    }
    
    // MARK: - Properties
    let viewModel: HomeViewModel
    var searchTimer: Timer?
    
    // MARK: - Views
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        
        view.isHidden = true
        
        view.registerCellClass(CryptoCardView.self)
        
        return view
    }()
    
    lazy var searchField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Enter symbol name to search"
        field.borderStyle = .none
        field.delegate = self
        field.clearButtonMode = .always
        field.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return field
    }()
    
    private lazy var loaderView: LoaderView = {
        let view = LoaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoaded()
        listenToViewModelChanges()
        setupUI()
    }
    
    // MARK: - Init
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewModel listeners
private extension HomeViewController {
    func listenToViewModelChanges() {
        viewModel.didCurrenciesViewModelChanged = { [weak self] currenciesViewModel in
            guard let `self` = self, let _ = currenciesViewModel else { return }
            DispatchQueue.main.async {
                self.tableView.isHidden = false
                self.loaderView.hide()
                self.configureMenu()
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - SetupUI
private extension HomeViewController {
    func setupUI() {
        view.backgroundColor = UIColor(hex: 0xf5f5f5)
        
        navigationItem.title = "Crypto Tracker"
        
        view.addSubview(searchField)
        view.addSubview(loaderView)
        view.addSubview(tableView)
        
        loaderView.show()
        
        configureConstraints()
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureMenu() {
        let activeCoinsMenuItem = UIAction(title: FilterType.activeCoins.rawValue) { [weak self] _ in
            guard let `self` = self else { return }
            viewModel.filter(by: .activeCoins)
        }
        
        let onlyCoinsMenuItem = UIAction(title: FilterType.onlyCoins.rawValue) { [weak self] _ in
            guard let `self` = self else { return }
            viewModel.filter(by: .onlyCoins)
        }
        
        let onlyTokensMenuItem = UIAction(title: FilterType.onlyTokens.rawValue) { [weak self] _ in
            guard let `self` = self else { return }
            viewModel.filter(by: .onlyTokens)
        }
        
        let newCryptoMenuItem = UIAction(title: FilterType.newCrypto.rawValue) { [weak self] _ in
            guard let `self` = self else { return }
            viewModel.filter(by: .newCrypto)
        }
        
        let resetMenuItem = UIAction(title: FilterType.reset.rawValue) { [weak self] _ in
            guard let `self` = self else { return }
            viewModel.filter(by: .reset)
        }
        
        let menu = UIMenu(title: "", children: [activeCoinsMenuItem, onlyCoinsMenuItem ,onlyTokensMenuItem, newCryptoMenuItem, resetMenuItem])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, image: UIImage.actions, primaryAction: nil, menu: menu)
    }
}
