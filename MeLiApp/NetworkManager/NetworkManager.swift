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
