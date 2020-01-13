//
//  ViewModelProtocols.swift
//  MeLiApp
//
//  Created by Mauro Worobiej on 12/01/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import Foundation

protocol FetchItemProtocol {
    
    // TODO:- Make a generic method instad of this three
    
    func fetchItemsByName( itemName: String, _ completion: @escaping (Results<ItemModel,Error>) -> Void)
    
    func fetchItemsById(itemId: String, _ completion: @escaping (Results<DetailModel,Error>) -> Void) 

    func fetchItemDescription( itemId: String, _ completion: @escaping (Results<DescriptionModel,Error>) -> Void)
}
