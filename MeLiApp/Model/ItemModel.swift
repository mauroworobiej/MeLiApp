//
//  ItemModel.swift
//  MeLiApp
//
//  Created by Mauro Worobiej on 05/01/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import Foundation

// MARK: - ItemModel
struct ItemModel: Codable {
    let results: [Result]
    enum CodingKeys: String, CodingKey {
        case results
    }
    
    init(results: [Result]) {
        self.results = results
    }
}

// MARK: - Result
class Result: Codable {
    let id: String
    let title: String
    let price: Double
    let condition: String
    let availableQuantity, soldQuantity: Int
    let permalink: String
    let thumbnail: String
    let acceptsMercadopago: Bool
    let shipping: Shipping?
    let originalPrice: Double?
    let officialStoreID: Int?
    let catalogProductID: String?
    let installments: Installments
    
    enum CodingKeys: String, CodingKey {
        case id
        case title, price, condition
        case availableQuantity = "available_quantity"
        case soldQuantity = "sold_quantity"
        case permalink, thumbnail
        case acceptsMercadopago = "accepts_mercadopago"
        case shipping
        case originalPrice = "original_price"
        case officialStoreID = "official_store_id"
        case catalogProductID = "catalog_product_id"
        case installments
    }
    
    init(id: String, title: String, price: Double, availableQuantity: Int, soldQuantity: Int, stopTime: String, permalink: String, thumbnail: String, acceptsMercadopago: Bool, shipping: Shipping, originalPrice: Double?, officialStoreID: Int?, catalogProductID: String?, installments: Installments, condition: String) {
        self.id = id
        self.title = title
        self.price = price
        self.availableQuantity = availableQuantity
        self.soldQuantity = soldQuantity
        self.permalink = permalink
        self.thumbnail = thumbnail
        self.acceptsMercadopago = acceptsMercadopago
        self.shipping = shipping
        self.originalPrice = originalPrice
        self.officialStoreID = officialStoreID
        self.catalogProductID = catalogProductID
        self.installments = installments
        self.condition = condition
    }
}

// MARK: - Shipping
class Shipping: Codable {
    let freeShipping: Bool
    
    enum CodingKeys: String, CodingKey {
        case freeShipping = "free_shipping"
    }
    
    init(freeShipping: Bool) {
        self.freeShipping = freeShipping
    }
}

class Installments: Codable {
    let quantity: Int
    init(quantity: Int) {
        self.quantity = quantity
    }
}

