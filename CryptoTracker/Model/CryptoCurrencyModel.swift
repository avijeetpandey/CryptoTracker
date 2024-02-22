//
//  CryptoCurrencyModel.swift
//  CryptoTracker
//
//  Created by Avijeet on 22/02/24.
//

import Foundation


/*
 The fields are marked as optional because , there might be a case that while parsing API response
 Some of the keys may not be present or can be nulls , to be on safer side we can handle them
 explicitly if thats the case.
 */


// MARK: - CryptoCurrenciesModel
struct CryptoCurrenciesModel: Codable {
    let cryptoCurrencies: [CryptoCurrencyModel]?
    
    private enum CodingKeys: String, CodingKey {
        case cryptoCurrencies = "cryptocurrencies"
    }
}

// MARK: - CryptoCurrencyModel
struct CryptoCurrencyModel: Codable {
    let name: String?
    let symbol: String?
    let isNew: Bool?
    let isActive: Bool?
    let type: String?
    
   private enum CodingKeys: String, CodingKey {
        case name
        case symbol
        case isNew = "is_new"
        case isActive = "is_active"
        case type
    }
}
