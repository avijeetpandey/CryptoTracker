//
//  CryptoCard.swift
//  CryptoTracker
//
//  Created by Avijeet on 22/02/24.
//

import Foundation
import UIKit

// MARK: - CryptoCardView
class CryptoCardView: UITableViewCell {
    
    // MARK: Views
    private lazy var cryptoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var newRibbonImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.image = .new
        view.isHidden = true
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

// Mark: ViewModel bindings
extension CryptoCardView: Bindable {
    typealias ViewModel = CryptoCardViewModel
    
    func bind(to viewModel: ViewModel) {
        cryptoImageView.image = viewModel.image
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        
        if(viewModel.isNew) {
            newRibbonImage.isHidden = false
        } else {
            newRibbonImage.isHidden = true
        }
    }
}

// MARK: - setupUI
private extension CryptoCardView {
    
    func setupUI() {
        addSubview(cryptoImageView)
        addSubview(newRibbonImage)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        
        selectionStyle = .none
        
        configureConstraints()
    }
    
    // MARK: - configuring constraints
    func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            
            newRibbonImage.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            newRibbonImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            newRibbonImage.heightAnchor.constraint(equalToConstant: 20),
            newRibbonImage.widthAnchor.constraint(equalToConstant: 20),
            
            cryptoImageView.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            cryptoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cryptoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            cryptoImageView.heightAnchor.constraint(equalToConstant: 40),
            cryptoImageView.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
}
