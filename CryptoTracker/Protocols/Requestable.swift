//
//  Requestable.swift
//  CryptoTracker
//
//  Created by Avijeet on 22/02/24.
//

import Foundation


// Protocol to implement network client functions in order to send Request
protocol Requestable {
    func sendRequest<T: Codable>(networkObject: NetworkRequestObject, completion: @escaping (Result<T,NetworkError>) -> Void)
}
