//
//  NetworkRequestObjectProtocol.swift
//  CryptoTracker
//
//  Created by Avijeet on 22/02/24.
//

import Foundation

// MARK: - NetworkRequestObjectProtocol
protocol NetworkRequestObjectProtocol {
    var url: String { get }
    var method: HttpMethods { get }
}
