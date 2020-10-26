//
//  GamesTableViewController.swift
//  MyGameList
//
//  Created by Kelvin Batista Machado on 11/10/20.
//  Copyright © 2020 Kelvin Batista Machado. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class SectionsData {
    var platformName: String?
    var gameName: [String]?
    
    init(platformName: String, gameName: [String]) {
        self.platformName = platformName
        self.gameName = gameName
    }
}

class GamesTableViewController: UITableViewController {
    
    @IBOutlet weak var parentTitle: UILabel!
    
    var parentName = ""
    var numChildsPlatforms = 0
    
    let realm = try! Realm()
    var parents: RealmSwift.Results<GameParentPlatform>?
    
    var deleteGame = false
    
    var sections: [String] = []
    
    var secData = [SectionsData]()
    
    var gameInfoVC = GameInfoViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.parentTitle.text = parentName
        
        navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = ""
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        tableView.rowHeight = 65.0
        
        fillTable()
    }
    
    func fillTable() {
        secData.removeAll()
        sections.removeAll()
        
        parents = realm.objects(GameParentPlatform.self)
        if parents!.count > 0 {
            for i in 0...parents!.count-1 {
                if parentName == parents![i].nameParentPlatform {
                    numChildsPlatforms = parents![i].childPlatforms.count
                    
                    for j in 0...parents![i].childPlatforms.count-1 {
                        sections.append(parents![i].childPlatforms[j].namePlatform)
                        var gameslist: [String] = []
                        for k in 0...parents![i].childPlatforms[j].myGames.count-1 {
                            gameslist.append(parents![i].childPlatforms[j].myGames[k].name)
                        }
                        
                        secData.append(SectionsData.init(platformName: parents![i].childPlatforms[j].namePlatform, gameName: gameslist))
                    }
                }
            }
        } else {
            navigationController?.popViewController(animated: true)
        }
        tableView.reloadData()
    }
    
    func getInfo(parent:String, platform:String, gameName:String) {
        parents = realm.objects(GameParentPlatform.self)
        
        for i in 0...parents!.count-1 {
            if parent == parents![i].nameParentPlatform {
                for j in 0...parents![i].childPlatforms.count-1 {
                    if platform == parents![i].childPlatforms[j].namePlatform {
                        for k in 0...parents![i].childPlatforms[j].myGames.count-1 {
                            if gameName == parents![i].childPlatforms[j].myGames[k].name{
                                if !deleteGame {
                                    gameInfoVC.nomejogo = gameName
                                    gameInfoVC.imagem = parents![i].childPlatforms[j].myGames[k].backgroundImage
                                    gameInfoVC.desc = parents![i].childPlatforms[j].myGames[k].gameDescription
                                } else {
                                    do {
                                        try self.realm.write {
                                            self.realm.delete(parents![i].childPlatforms[j].myGames[k])
                                            
                                            if parents![i].childPlatforms[j].myGames.isEmpty {
                                                
                                                self.realm.delete(parents![i].childPlatforms[j])
                                            }
                                            
                                            if parents![i].childPlatforms.isEmpty {
                                                self.realm.delete(parents![i])
                                                
                                                navigationController?.popViewController(animated: true)
                                            }
                                        }
                                    } catch {
                                        print("Erro ao deletar jogo, \(error)")
                                    }
                                    
                                }
                                deleteGame = false
                                break
                            }
                        }
                    }
                }
            }
        }
        
        fillTable()
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return secData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return secData[section].gameName?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return secData[section].platformName
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        
        cell.textLabel?.text = secData[indexPath.section].gameName?[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        getInfo(parent: parentName, platform: secData[indexPath[0]].platformName!, gameName: secData[indexPath[0]].gameName![indexPath[1]])
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "goToGameInfo", sender: self)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is GameInfoViewController
        {
            let vc = segue.destination as? GameInfoViewController
            vc?.nomejogo = gameInfoVC.nomejogo
            vc?.imagem = gameInfoVC.imagem
            vc?.desc = gameInfoVC.desc
        }
    }
    
}


//MARK: - Swipe Cell Delegate Methods

extension GamesTableViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil}
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [self] (action, indexPath) in
            
            deleteGame = true
            getInfo(parent: parentName, platform: secData[indexPath[0]].platformName!, gameName: secData[indexPath[0]].gameName![indexPath[1]])
        }
        
        deleteAction.image = UIImage(named: "delete")
        
        return [deleteAction]
    }
    
}
