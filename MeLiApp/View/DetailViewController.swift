//
//  DetailViewController.swift
//  MeLiApp
//
//  Created by Mauro Worobiej on 06/01/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemQuantity: UILabel!
    @IBOutlet weak var itemStock: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
