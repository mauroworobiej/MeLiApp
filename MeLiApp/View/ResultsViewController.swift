//
//  ResultsViewController.swift
//  MeLiApp
//
//  Created by Mauro Worobiej on 05/01/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import UIKit
import SDWebImage

class ResultsViewController: UIViewController, UITableViewDataSource {

    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var resultTableView: UITableView!
    var itemName: String?
    var searchViewModel: SearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(self.activityIndicator)
        activityIndicator.startAnimating()
        // due to the Async process we pass a completion to wait the data load
        guard let itemName = itemName else {
            print("Failed getting Item Name")
            return
        }
        self.searchViewModel = SearchViewModel(itemName: itemName, completion: { [weak self] in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.resultTableView.reloadData()
                strongSelf.activityIndicator.stopAnimating()
                strongSelf.activityIndicator.removeFromSuperview()
            }
        })
    }
    
    // MARK: - Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.getTotalItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ResultTableViewCell
        let index = indexPath.row
        DispatchQueue.main.async {
            let imageItemString = self.searchViewModel.getItemThumbnail(index: index)
            cell.imageItem.sd_setImage(with: URL(string: imageItemString), placeholderImage: nil, options: [], completed: nil)
            cell.priceLabel.text = "$"+String(self.searchViewModel.getItemPrice(index: index))
            if (self.searchViewModel.getItemShipping(index: index)?.freeShipping) != nil {
                cell.shippingLabel.text = "Envío gratis"
            } else {
               cell.shippingLabel.isHighlighted = true
            }
//            tableView.reloadData()
        }
        return cell
    }    

}
