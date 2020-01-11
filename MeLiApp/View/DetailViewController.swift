//
//  DetailViewController.swift
//  MeLiApp
//
//  Created by Mauro Worobiej on 06/01/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController, UICollectionViewDataSource {
    var itemId = ""
    var detailViwModel: DetailViewModel!

    @IBOutlet weak var detailCollectionView: UICollectionView!
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

            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.detailCollectionView.reloadData()
                strongSelf.activityIndicator.stopAnimating()
                strongSelf.activityIndicator.removeFromSuperview()
                if let soldQuantity = strongSelf.detailViwModel.getItemSoldQuantity() {
                    strongSelf.itemQuantity.text = strongSelf.detailViwModel.getItemCondition() + " - " + soldQuantity
                } else {
                    strongSelf.itemQuantity.text = strongSelf.detailViwModel.getItemCondition()
                }
                strongSelf.itemStock.text = "Cantidad disponible: " + strongSelf.detailViwModel.getItemStock()
                strongSelf.itemPrice.text = "$" + strongSelf.detailViwModel.getItemPrice()
                strongSelf.itemTitle.text = strongSelf.detailViwModel.getItemTitle()
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5//detailViwModel.getTotalItemImage()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = detailCollectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollectionCell", for: indexPath) as! DetailCollectionViewCell
//        let cell = detailCollectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollectionCell", for: indexPath) as! CollectionViewCell
        let imagenUrl = detailViwModel.getItemImage(index: indexPath.row)
        DispatchQueue.main.async {
            cell.itemImage.sd_setImage(with: URL(string: imagenUrl), placeholderImage: nil, options: [], completed: nil)
        }
        return cell
    }
}
