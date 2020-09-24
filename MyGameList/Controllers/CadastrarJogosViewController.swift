//
//  CadastrarJogosViewController.swift
//  MyGameList
//
//  Created by Kelvin Batista Machado on 17/09/20.
//  Copyright © 2020 Kelvin Batista Machado. All rights reserved.
//

import UIKit

class CadastrarJogosViewController: UIViewController, UISearchControllerDelegate {
    
    let searchBar = UISearchController()
    var searchingGame = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuraSearchBar()
        
    }
    
    func configuraSearchBar() {
        
        searchBar.searchBar.delegate = self
        
        searchBar.searchBar.autocapitalizationType = .words
        searchBar.searchBar.keyboardType = .namePhonePad
        searchBar.searchBar.sizeToFit()
        searchBar.searchBar.backgroundColor = .clear
        searchBar.searchBar.searchTextField.backgroundColor = .white
        searchBar.searchBar.placeholder = "Informe o nome do jogo"
        searchBar.searchBar.isTranslucent = false
        navigationItem.searchController = searchBar
    }
    
    @IBAction func backToMenu(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension CadastrarJogosViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchingGame = searchText
        print(searchText)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("End editing: \(searchingGame)")
    }
    
}
