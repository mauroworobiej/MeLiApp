//
//  DetailViewController.swift
//  MeLiApp
//
//  Created by Mauro Worobiej on 06/01/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var itemId = ""
    var detailViwModel: DetailViewModel!

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemQuantity: UILabel!
    @IBOutlet weak var itemStock: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(self.activityIndicator)
        activityIndicator.startAnimating()
        // due to the Async process we pass a completion to wait the data load
        
        //        TODO:- user feedback when the result is empty
        self.detailViwModel = DetailViewModel(itemId: itemId, completion: { [weak self] in
            
        //ResultViewModel(itemName: itemName, completion: { [weak self] in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.activityIndicator.stopAnimating()
                strongSelf.activityIndicator.removeFromSuperview()
            }
        })
    }
    
}
