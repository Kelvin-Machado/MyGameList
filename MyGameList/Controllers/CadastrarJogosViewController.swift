//
//  CadastrarJogosViewController.swift
//  MyGameList
//
//  Created by Kelvin Batista Machado on 17/09/20.
//  Copyright © 2020 Kelvin Batista Machado. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire

class CadastrarJogosViewController: UIViewController, UISearchControllerDelegate {
    //
    //    let main = DispatchQueue.main
    let background = DispatchQueue.global()
    
    let searchBar = UISearchController()
    var searchingGame = ""
    var salvarVC = SalvarNovoJogoViewController()
    
    @IBOutlet weak var nomeJogo: UILabel!
    @IBOutlet weak var imagemJogo: UIImageView!
    @IBOutlet weak var jogoView: UIView!
    @IBOutlet weak var descricaoJogo: UITextView!
    
    @IBOutlet weak var adicionarBtn: UIButton!
    
    static var numberChilds: Int = 0
    var parentGames = [GameParentPlatform]()
    var platformsIds = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jogoView.layer.cornerRadius = jogoView.frame.height/10
        descricaoJogo.isEditable = false
        descricaoJogo.backgroundColor = .clear
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
            vc?.metaURL = salvarVC.metaURL
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
                DispatchQueue.main.async {
                    self.fetchGameSlug(slug: games.slug)
                }
                
            }
        }
        DispatchQueue.main.async {
            self.fetchGameSlug(slug: self.searchingGame)
        }
        
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
            self.salvarVC.imgUrl = games.backgroundImageAdditional
            self.salvarVC.metaURL = games.metacriticURL
            
            CadastrarJogosViewController.numberChilds = 0
            
            //adiciona todas as parent platforms em um array
            self.background.sync {
                for index in 0...games.parentPlatforms.count-1 {
                    let  parentPlatform = GameParentPlatform()
                    parentPlatform.id = games.parentPlatforms[index].platform.id
                    
                    parentPlatform.nameParentPlatform = games.parentPlatforms[index].platform.name
                    
                    self.parentGames.append(parentPlatform)
                    
                    //pegar a Id da plataforma (ps4, ps3, xbox 360...)
                    print("platforms: \(games.platforms.count)")
                    print("parentPlatforms: \(games.parentPlatforms.count)")
                    print("Parent Platform: \(games.parentPlatforms[index].platform.name)")
                    
                    for i in 0...games.platforms.count-1 {
                        print("Platform \(games.platforms[i].platform.name)")
                        
                    }
                    
//                    print(games.platforms.count)
                    
//                    let i = games.parentPlatforms.count
//                    print("numero de plataformas: \(i)")

//                    print("Plataformas: \(self.parentGames)")
                }
            }
            
            self.descricaoJogo.backgroundColor = #colorLiteral(red: 0.9147711396, green: 0.9093332887, blue: 0.9189512134, alpha: 1)
        }
        print("fim do request")
        
    }
    
    func fetchNumberChildPlatforms(id: Int) {
        
        let request = AF.request("https://api.rawg.io/api/platforms/lists/parents")
        print("Id passada: \(id)")
        
        var numberChildPlatforms = 0
        request.responseDecodable(of: ParentsList.self) { (response) in
            guard let parents = response.value else { return }
            
            outerLoop: for index in 0...parents.count-1 {
                if parents.results[index].id == id {
                    numberChildPlatforms =  parents.results[index].platforms.count
                    CadastrarJogosViewController.numberChilds = numberChildPlatforms
                    break outerLoop
                }
            }
        }
    }
}

