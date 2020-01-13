//
//  ResultViewModel.swift
//  MeLiApp
//
//  Created by Mauro Worobiej on 05/01/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import Foundation

class ResultViewModel {
    
    private let networkManager: FetchItemProtocol
    private var serchedItems: [Result] = []
    
    init(networkManager: FetchItemProtocol = NetworkManager(), itemName: String, completion: @escaping () -> Void) {
        self.networkManager = networkManager
        networkManager.fetchItemsByName(itemName: itemName) { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
                case .success(let data):
                    strongSelf.serchedItems = data.results
                case .failure(let error):
                    print("Fetch Error: \(error)")
            }
        completion()
        }
    }
    
    func getItemId(index: Int) -> String {
        return serchedItems[index].id
    }
    
    func getItemTitle(index: Int) -> String {
        return serchedItems[index].title
    }
    
    func getItemPrice(index: Int) -> Double {
        return serchedItems[index].price
    }
    
    func getItemThumbnail(index: Int) -> String {
        return serchedItems[index].thumbnail
    }
    
    func getItemShipping(index: Int) -> Shipping? {
        return serchedItems[index].shipping
    }
    
    func getTotalItems() -> Int {
        return serchedItems.count
    }
}
