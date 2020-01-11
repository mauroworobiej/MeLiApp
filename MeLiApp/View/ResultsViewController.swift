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
    var resultViewModel: ResultViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(self.activityIndicator)
        activityIndicator.startAnimating()
        // due to the Async process we pass a completion to wait the data load
        guard let itemName = itemName else {
            print("Failed getting Item Name")
            return
        }
        //        TODO:- user feedback when the result is empty
        self.resultViewModel = ResultViewModel(itemName: itemName, completion: { [weak self] in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.resultTableView.reloadData()
                strongSelf.activityIndicator.stopAnimating()
                strongSelf.activityIndicator.removeFromSuperview()
            }
        })
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let cell = sender as? UITableViewCell,
                let index = resultTableView.indexPath(for: cell) else { return }
            if let detailtVC = segue.destination as? DetailViewController {
                DispatchQueue.main.async {
                    let imageItemString = self.resultViewModel.getItemThumbnail(index: index.row)
                    detailtVC.itemImage.sd_setImage(with: URL(string: imageItemString), placeholderImage: nil, options: [], completed: nil)
                    detailtVC.itemQuantity.text = String(self.resultViewModel.getCondition(index: index.row)) + " - " + String(self.resultViewModel.getSoldQuantity(index: index.row))
                    detailtVC.itemPrice.text = "$" + String(self.resultViewModel.getItemPrice(index: index.row))
                    detailtVC.itemStock.text = "Stock: " + String(self.resultViewModel.getItemQuantity(index: index.row))
                }
               
            }
        }
    }
    
    // MARK: - Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultViewModel.getTotalItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ResultTableViewCell
        let index = indexPath.row
        DispatchQueue.main.async {
            let imageItemString = self.resultViewModel.getItemThumbnail(index: index)
            cell.imageItem.sd_setImage(with: URL(string: imageItemString), placeholderImage: nil, options: [], completed: nil)
            cell.titleLabel.text = self.resultViewModel.getItemTitle(index: index)
            cell.priceLabel.text = "$" + String(self.resultViewModel.getItemPrice(index: index))
            if (self.resultViewModel.getItemShipping(index: index)?.freeShipping) != nil {
                cell.shippingLabel.text = "Envío gratis"
            } else {
               cell.shippingLabel.isHighlighted = true
            }
//            tableView.reloadData()
        }
        return cell
    }    

}
