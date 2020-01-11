//
//  DetailModel.swift
//  MeLiApp
//
//  Created by Mauro Worobiej on 09/01/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import Foundation

class DetailModel: Codable {
    let id, title: String
    let sellerID: Int
    let categoryID: String
    let price: Double
    let initialQuantity, availableQuantity, soldQuantity: Int
    let condition: String
    let permalink: String
    let thumbnail: String
    let secureThumbnail: String
    let pictures: [Picture]
    let descriptions: [Description]
    let acceptsMercadopago: Bool
    let status: String
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case sellerID = "seller_id"
        case categoryID = "category_id"
        case price
        case initialQuantity = "initial_quantity"
        case availableQuantity = "available_quantity"
        case soldQuantity = "sold_quantity"
        case condition, permalink, thumbnail
        case secureThumbnail = "secure_thumbnail"
        case pictures
        case descriptions
        case acceptsMercadopago = "accepts_mercadopago"
        case status
        
    }
    
    init(id: String, title: String, sellerID: Int, categoryID: String, price: Double,  initialQuantity: Int, availableQuantity: Int, soldQuantity: Int, condition: String, permalink: String, thumbnail: String, secureThumbnail: String, pictures: [Picture], descriptions: [Description], acceptsMercadopago: Bool, status: String) {
        self.id = id
        self.title = title
        self.sellerID = sellerID
        self.categoryID = categoryID
        self.price = price
        self.initialQuantity = initialQuantity
        self.availableQuantity = availableQuantity
        self.soldQuantity = soldQuantity
        self.condition = condition
        self.permalink = permalink
        self.thumbnail = thumbnail
        self.secureThumbnail = secureThumbnail
        self.pictures = pictures
        self.descriptions = descriptions
        self.acceptsMercadopago = acceptsMercadopago
        self.status = status
    }
}


// MARK: - Description
class Description: Codable {
    let id: String
    
    init(id: String) {
        self.id = id
    }
}


// MARK: - Picture
class Picture: Codable {
    let url: String
    let secureURL: String
    
    enum CodingKeys: String, CodingKey {
        case url
        case secureURL = "secure_url"
    }
    
    init(url: String, secureURL: String) {
        self.url = url
        self.secureURL = secureURL
    }
}
