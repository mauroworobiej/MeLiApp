//
//  DetailViewModel.swift
//  MeLiApp
//
//  Created by Mauro Worobiej on 09/01/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import Foundation

class DetailViewModel {
    
//    https://api.mercadolibre.com/items?ids=
    
    private let networkManager = NetworkManager()
//    private let url : URL
    private var itemDetail: DetailModel!
    private var itemDescription: DescriptionModel!
    
    init(itemId: String, completion: @escaping () -> Void) {
//        let urlString = "https://api.mercadolibre.com/sites/MLA/search?q=" + itemName
//        guard let url = URL(string: urlString) else {
//            fatalError("Invalid URL")
//        }
//        self.url = url
        // I pass a completion to wait the data load
        self.fetchItemsById(completion, itemId: itemId)
    }
    
    private func fetchItemsById(_ completion: @escaping () -> Void, itemId: String) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.mercadolibre.com"
        urlComponents.path = "/items/" + itemId
        
        guard let url = urlComponents.url else {//URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        networkManager.performRequest(type: DetailModel.self, url: url) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let parsedJson):
                strongSelf.itemDetail = parsedJson
            case .failure(let error):
                print("failed parsing JSON", error)
            }
//            completion()
            strongSelf.fetchItemDescription(completion, itemId: itemId)
        }
    }
    
    private func fetchItemDescription(_ completion: @escaping () -> Void, itemId: String) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.mercadolibre.com"
        urlComponents.path = "/items/" + itemId + "/descriptions"
        
        guard let url = urlComponents.url else {//URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        networkManager.performRequest(type: DescriptionModel.self, url: url) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let parsedJson):
                strongSelf.itemDescription = parsedJson
            case .failure(let error):
                print("failed parsing JSON", error)
            }
            completion()
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
