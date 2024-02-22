//
//  NetworkClient.swift
//  CryptoTracker
//
//  Created by Avijeet on 22/02/24.
//

import Foundation

// MARK: - NetworkClient

// Using ApiManager as a singleton and only single point for making network calls to the server
class NetworkClient: Requestable {
    
    static let shared = NetworkClient()
    
    private init() {}
    
    
    // function to make network call using the Url , method and Expected data provided
    func sendRequest<T: Codable>(networkObject: NetworkRequestObject, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard let url = URL(string: networkObject.url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = networkObject.method.rawValue
        request.httpBody = networkObject.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data ,response, error) in
            
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingFailed(error)))
            }
        }
        
        
        
        task.resume()
    }
}
