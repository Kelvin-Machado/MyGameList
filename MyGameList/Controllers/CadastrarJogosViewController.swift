//
//  CadastrarJogosViewController.swift
//  MyGameList
//
//  Created by Kelvin Batista Machado on 17/09/20.
//  Copyright © 2020 Kelvin Batista Machado. All rights reserved.
//

import UIKit
import Alamofire

class CadastrarJogosViewController: UIViewController, UISearchControllerDelegate {
    
    let searchBar = UISearchController()
    var searchingGame = ""
    var salvarVC = SalvarNovoJogoViewController()
    
    @IBOutlet weak var nomeJogo: UILabel!
    @IBOutlet weak var imagemJogo: UIImageView!
    @IBOutlet weak var jogoView: UIView!
    @IBOutlet weak var descricaoJogo: UITextView!
    
    @IBOutlet weak var adicionarBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jogoView.layer.cornerRadius = jogoView.frame.height/10
        descricaoJogo.isEditable = false
        imagemJogo.layer.cornerRadius = 30
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SalvarNovoJogoViewController
        {
            let vc = segue.destination as? SalvarNovoJogoViewController
            vc?.nome = salvarVC.nome
            vc?.imgUrl = salvarVC.imgUrl
            vc?.notaMeta = salvarVC.notaMeta
        }
    }
    
}

extension CadastrarJogosViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchingGame = searchText
        print(searchText)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print(searchingGame)
        if searchingGame != "" {
            searchingGame = searchingGame.replacingOccurrences(of: " ", with: "-", options: NSString.CompareOptions.literal, range:nil)
            print("End editing: \(searchingGame)")
            fetchGameName()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchingGame = ""
    }
    
}

// Request
extension CadastrarJogosViewController {
    
    func fetchGameName() {
        let request = AF.request("https://api.rawg.io/api/games/\(searchingGame)")
        
        // procura o jogo pelo nome passado
        request.responseDecodable(of: Search.self) { (response) in
            guard let games = response.value else { return }
            print(games.redirect)
            print(games.slug)
            
            if games.redirect {
                self.fetchGameSlug(slug: games.slug)
            }
        }
        self.fetchGameSlug(slug: self.searchingGame)
    }
    
    func fetchGameSlug(slug: String) {
        //procura o jogo pelo slug recebido, ou pelo nome passado em caso de erro
        let request = AF.request("https://api.rawg.io/api/games/\(slug)")
        print("Slug passado: \(slug)")
        request.responseDecodable(of: Game.self) { (response) in
            guard let games = response.value else { return }
            self.nomeJogo.text = games.nameOriginal
            self.descricaoJogo.text = games.descriptionRaw
            self.imagemJogo.load(url: URL(string: games.backgroundImage)!)
            
            self.salvarVC.nome = games.nameOriginal
            self.salvarVC.notaMeta = games.metacritic ?? 0
            self.salvarVC.imgUrl = games.backgroundImage
            print(self.salvarVC.imgUrl)
            self.jogoView.backgroundColor = UIColor.init(named: games.dominantColor)?.withAlphaComponent(0.5)
            
        }
        print("fim do request")
        
    }
}

