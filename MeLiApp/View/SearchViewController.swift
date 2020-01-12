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
        searchBar.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultSegue" {
            if let resultVC = segue.destination as? ResultsViewController {
                guard let searchText = searchBar.text else {
                    return
                }
                if searchText.count < 1 {
                    let alert = UIAlertController(title: "Atencion", message: "El campo de busqueda debe contener texto, por favor introduzca el nombre del articulo a buscar", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    return
                }
                resultVC.itemName = searchBar.text
            }
        }
    }

}

