//
//  LoaderView.swift
//  CryptoTracker
//
//  Created by Avijeet on 23/02/24.
//

import Foundation
import UIKit

// MARK: - LoaderView
class LoaderView: UIView {
    private (set) var isAnimating: Bool = false {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }
                
                self.configureState()
            }
        }
    }
    
    private lazy var spinnerView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = UIColor(hex: 0x262626)
        return view
    }()
    
    // MARK: - Init
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    public func show() {
        self.isAnimating = true
    }
    
    public func hide() {
        self.isAnimating = false
    }
    
    public func removeFromSuperView() {
        self.isAnimating = false
        self.removeFromSuperview()
    }
}

// MARK: - State
private extension LoaderView {
    func configureState() {
        if isAnimating {
            self.alpha = 1
            spinnerView.startAnimating()
        } else {
            spinnerView.stopAnimating()
            self.alpha = 0
        }
    }
}


// MARK: - setupUI
private extension LoaderView {
    func setupUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        addSubview(spinnerView)
        
        configureConstraints()
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            spinnerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            spinnerView.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            spinnerView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            self.widthAnchor.constraint(equalToConstant: 80),
            self.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}
