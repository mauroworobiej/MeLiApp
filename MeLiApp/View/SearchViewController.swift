//
//  SearchViewController.swift
//  MeLiApp
//
//  Created by Mauro Worobiej on 04/01/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
//
//    @IBAction func searchItem(_ sender: UIButton) {
//        if searchBar.text != "" {
//            performSegue(withIdentifier: "resultSegue", sender: nil)
//        }
//    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultSegue" {
            if let resultVC = segue.destination as? ResultsViewController {
                resultVC.itemName = searchBar.text ?? ""
            }
        }
    }

}

