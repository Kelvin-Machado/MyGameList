//
//  GamesTableViewController.swift
//  MyGameList
//
//  Created by Kelvin Batista Machado on 11/10/20.
//  Copyright © 2020 Kelvin Batista Machado. All rights reserved.
//

import UIKit
import RealmSwift

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
    var parents: RealmSwift.Results<GameParentPlatform>?
    
    var sections: [String] = []
    
    var secData = [SectionsData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.parentTitle.text = parentName
        
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = secData[indexPath.section].gameName?[indexPath.row]
        
        return cell
    }
    
}
