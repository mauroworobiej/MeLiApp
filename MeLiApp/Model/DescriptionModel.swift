//
//  DescriptionModel.swift
//  MeLiApp
//
//  Created by Mauro Worobiej on 11/01/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import Foundation

struct DescriptionModelElement: Codable {
    let id, created, text, plainText: String
    let snapshot: Snapshot
    
    enum CodingKeys: String, CodingKey {
        case id, created, text
        case plainText = "plain_text"
        case snapshot
    }
}

// MARK: - Snapshot
struct Snapshot: Codable {
    let url: String
    let width, height: Int
    let status: String
}

typealias DescriptionModel = [DescriptionModelElement]
