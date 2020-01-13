//
//  MeLiAppTests.swift
//  MeLiAppTests
//
//  Created by Mauro Worobiej on 12/01/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import XCTest
@testable import MeLiApp

// TODO:- get a json mock for all the fetch method and test every fetch method
// TODO:- make a test for every VM and make a test for every VM method

class MeLiAppTests: XCTestCase {
    
    let networkManager = MockNetworkRequest(byNameShouldFail: true, byIdShouldFail: false, byDescriptionShouldFail: true)
    
    override func setUp() {
    }

    func testDetailViewModel() {
        let viewModel = DetailViewModel(networkManager: networkManager, itemId: "MLA796598770") {}
        
        XCTAssertEqual(viewModel.getItemCondition(),"new")
        XCTAssertEqual(viewModel.getItemPrice(),"361.8")
        XCTAssertEqual(viewModel.getItemStock(),"52")
        XCTAssertEqual(viewModel.getItemTitle(),"Art.5604 - Colaless Alg&l Lisa Promo X 3 Unidades Surt Cocot")
    }

}
