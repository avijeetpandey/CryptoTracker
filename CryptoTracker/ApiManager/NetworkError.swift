//
//  NetworkError.swift
//  CryptoTracker
//
//  Created by Avijeet on 22/02/24.
//

import Foundation

// MARK: - NetworkError
enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
}
