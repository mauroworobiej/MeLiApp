//
//  DetailViewModel.swift
//  MeLiApp
//
//  Created by Mauro Worobiej on 09/01/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import Foundation

class DetailViewModel {
    
    private let networkManager: FetchItemProtocol
    private var itemDetail: DetailModel!
    private var itemDescription: DescriptionModel!
    
    init(networkManager: FetchItemProtocol = NetworkManager(), itemId: String, completion: @escaping () -> Void) {
        
        self.networkManager = networkManager
        
        networkManager.fetchItemsById(itemId: itemId) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let data):
                strongSelf.itemDetail = data
            case .failure(let error):
                print("Fetch Error: \(error)")
            }
            
            networkManager.fetchItemDescription(itemId: itemId) { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let data):
                    strongSelf.itemDescription = data
                case .failure(let error):
                    print("Fetch Error: \(error)")
                }
            // Return the completion only when I loaded the two models
            completion()
            }
        }
    }
    
    
    
    func getItemImage(index: Int) -> String {
        return itemDetail.pictures[index].url
    }
    
    func getTotalItemImage() -> Int {
        return itemDetail.pictures.count
    }
    
    func getItemSoldQuantity() -> String? {
        return String(itemDetail.soldQuantity)
    }
    
    func getItemCondition() -> String {
        return itemDetail.condition
    }
    
    func getItemPrice() -> String {
        return String(itemDetail.price)
    }
    
    func getItemStock() -> String {
        return String(itemDetail.availableQuantity)
    }
    
    func getItemTitle() -> String {
        return String(itemDetail.title)
    }
    
    func getItemDescription() -> String? {
        return itemDescription.first?.plainText
    }
}
