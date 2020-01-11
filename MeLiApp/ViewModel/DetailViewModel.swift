////
////  DetailViewModel.swift
////  MeLiApp
////
////  Created by Mauro Worobiej on 09/01/2020.
////  Copyright © 2020 Mauro Worobiej. All rights reserved.
////
//
//import Foundation
//
//class DetailViewModel {
//    
////    https://api.mercadolibre.com/items?ids=
//    let itemId: Int?
//    private let networkManager = NetworkManager()
//    private let url : URL
//    private var detailItem: [Result] = []
//    
//    init(itemName: String, completion: @escaping () -> Void) {
//        let urlString = "https://api.mercadolibre.com/sites/MLA/search?q=" + itemName
//        guard let url = URL(string: urlString) else {
//            fatalError("Invalid URL")
//        }
//        self.url = url
//        // I pass a completion to wait the data load
//        self.fetchItemsByName(completion)
//    }
//    
//    private func fetchItemsByName(_ completion: @escaping () -> Void) {
//        networkManager.performRequest(type: ItemModel.self, url: url) { [weak self] result in
//            guard let strongSelf = self else { return }
//            switch result {
//            case .success(let parsedJson):
//                strongSelf.serchedItems = parsedJson.results
//            case .failure(let error):
//                print("failed parsing JSON", error)
//            }
//            completion()
//        }
//    }
//}
