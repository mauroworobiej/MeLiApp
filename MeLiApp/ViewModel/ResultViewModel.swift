//
//  ResultViewModel.swift
//  MeLiApp
//
//  Created by Mauro Worobiej on 05/01/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import Foundation

class ResultViewModel {
    
    private let networkManager = NetworkManager()
    private let url : URL
    private var serchedItems: [Result] = []
    
    init(itemName: String, completion: @escaping () -> Void) {
        let urlString = "https://api.mercadolibre.com/sites/MLA/search?q=" + itemName
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        self.url = url
        // I pass a completion to wait the data load
        self.fetchItems(completion)
    }
    
    private func fetchItems(_ completion: @escaping () -> Void) {
        networkManager.performRequest(type: ItemModel.self, url: url) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let parsedJson):
                strongSelf.serchedItems = parsedJson.results
            case .failure(let error):
                print("failed parsing JSON", error)
            }
            completion()
        }
    }
    
    func getItemTitle(index: Int) -> String {
        return serchedItems[index].title
    }
    
    func getItemPrice(index: Int) -> Double {
        return serchedItems[index].price
    }
    
    func getItemQuantity(index: Int) -> Int {
        return serchedItems[index].availableQuantity
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
    
    func getAvailableQuantity(index: Int) -> Int {
        return serchedItems[index].availableQuantity
    }
    
    func getSoldQuantity(index: Int) -> Int {
        return serchedItems[index].soldQuantity
    }
    
    func getCondition(index: Int) -> String {
        return serchedItems[index].condition
    }
}
