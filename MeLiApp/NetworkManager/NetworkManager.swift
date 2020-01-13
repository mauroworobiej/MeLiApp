//
//  NetworkManager.swift
//  MeLiApp
//
//  Created by Mauro Worobiej on 04/01/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import Foundation

public enum Results<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)
}

class NetworkManager {
    
    init() {}
    
    // Generic function to re-use with every model in case to expand the app
     func performRequest<T: Codable>(type: T.Type, url : URL, completion : @escaping (Results<T,Error>) -> Void) {
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            //Failure
            if let error = error {
                completion(.failure(error))
                return
            }
            // Success
            guard let data = data else { return }
            do {
                let jsonResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(jsonResponse))
            } catch let parsingError {
                // Parsing failure
                completion(.failure(parsingError))
            }
        }.resume()
    }
}

extension NetworkManager: FetchItemProtocol {
    
    internal func fetchItemsByName( itemName: String, _ completion: @escaping (Results<ItemModel,Error>) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.mercadolibre.com"
        urlComponents.path = "/sites/MLA/search"
        let queryItem = URLQueryItem(name: "q", value: itemName)
        urlComponents.queryItems = [queryItem]
        
        guard let url = urlComponents.url else {
            fatalError("Invalid URL")
        }
        self.performRequest(type: ItemModel.self, url: url) { result in
            switch result {
            case .success(let parsedJson):
                completion(.success(parsedJson))
            case .failure(let error):
                print("failed parsing JSON", error)
                completion(.failure(error))
            }
        }
    }
    
    
    internal func fetchItemsById(itemId: String, _ completion: @escaping (Results<DetailModel,Error>) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.mercadolibre.com"
        urlComponents.path = "/items/" + itemId
        
        guard let url = urlComponents.url else {
            fatalError("Invalid URL")
        }
        self.performRequest(type: DetailModel.self, url: url) { result in
            switch result {
            case .success(let parsedJson):
                completion(.success(parsedJson))
            case .failure(let error):
                print("failed parsing JSON", error)
                completion(.failure(error))
            }
        }
    }
    
    internal func fetchItemDescription(itemId: String, _ completion: @escaping (Results<DescriptionModel,Error>) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.mercadolibre.com"
        urlComponents.path = "/items/" + itemId + "/descriptions"
        
        guard let url = urlComponents.url else {
            fatalError("Invalid URL")
        }
        self.performRequest(type: DescriptionModel.self, url: url) { result in
            switch result {
            case .success(let parsedJson):
                completion(.success(parsedJson))
            case .failure(let error):
                print("failed parsing JSON", error)
            }
        }
    }

}
