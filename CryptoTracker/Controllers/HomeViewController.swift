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
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - SetupUI
private extension HomeViewController {
    func setupUI() {
        view.backgroundColor = UIColor(hex: 0xf5f5f5)
        view.addSubview(loaderView)
        
        loaderView.show()
        
        view.addSubview(tableView)
        
        configureConstraints()
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

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
