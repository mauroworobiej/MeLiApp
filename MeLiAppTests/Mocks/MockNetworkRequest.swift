//
//  MockNetworkRequest.swift
//  MeLiAppTests
//
//  Created by Mauro Worobiej on 12/01/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import Foundation
@testable import MeLiApp

/// Type of fetch errors
public enum FectchError: Error {
    case parsingError
}

/// Return mock responses for testing
class MockNetworkRequest {
    
    private var byNameShouldFail: Bool
    private var byIdShouldFail: Bool
    private var byDescriptionShouldFail: Bool

    
    init(byNameShouldFail: Bool, byIdShouldFail: Bool, byDescriptionShouldFail: Bool ) {
        self.byNameShouldFail = byNameShouldFail
        self.byIdShouldFail = byIdShouldFail
        self.byDescriptionShouldFail = byDescriptionShouldFail
    }
    
    private func parseLocalJson<T:Codable>(type: T.Type,jsonName: String, bundle: Bundle) -> T?{
        if let path = bundle.path(forResource: jsonName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResponse = try JSONDecoder().decode(T.self, from: data)
                return jsonResponse
                }
             catch {
                print("Fail parsing local JSON")
            }
        }
        return nil
    }
}


extension MockNetworkRequest: FetchItemProtocol {
    
    func fetchItemsByName(itemName: String, _ completion: @escaping (Results<ItemModel, Error>) -> Void) {
        
        if(byNameShouldFail) {
            completion(.failure(FectchError.parsingError))
        } else {
            // Return Json
        }
    }
    
    func fetchItemsById(itemId: String, _ completion: @escaping (Results<DetailModel, Error>) -> Void) {
        
        if(byIdShouldFail) {
            completion(.failure(FectchError.parsingError))
        } else {
            let bundle = Bundle(for: type(of: self))

            let response = parseLocalJson(type: DetailModel.self, jsonName: "ResponseById", bundle: bundle)
            completion(.success(response!))
        }
    }
    
    func fetchItemDescription(itemId: String, _ completion: @escaping (Results<DescriptionModel, Error>) -> Void) {
        
        if(byDescriptionShouldFail) {
            completion(.failure(FectchError.parsingError))
        } else {
            // Return Json
        }
    }
    
    
    
    
}
