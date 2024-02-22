//
//  NetworkRequestObject.swift
//  CryptoTracker
//
//  Created by Avijeet on 22/02/24.
//

import Foundation

// MARK: - NetworkRequestObject
struct NetworkRequestObject: NetworkRequestObjectProtocol {
    private (set) var url: String
    private (set) var method: HttpMethods
    private (set) var body: Data?
    
    init(url: String, method: HttpMethods = .get, body: Data? = nil) {
        self.url = url
        self.method = method
        self.body = body
    }
}
