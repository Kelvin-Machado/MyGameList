//
//  SalvarNovoJogoViewController.swift
//  MyGameList
//
//  Created by Kelvin Batista Machado on 25/09/20.
//  Copyright © 2020 Kelvin Batista Machado. All rights reserved.
//

import UIKit
import DropDown

class SalvarNovoJogoViewController: UIViewController {
    
    
    @IBOutlet weak var nomeJogo: UILabel!
    @IBOutlet weak var ImagemJogo: UIImageView!
    @IBOutlet weak var metascore: UILabel!
    @IBOutlet weak var metacritic: UIButton!
    
    var nome = ""
    var imgUrl = ""
    var notaMeta = 0
    var metaURL = ""
    
    var plataformasParent = [GameParentPlatform]()
    
    let dropDown = DropDown()
    var dropDownBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nomeJogo.text = nome

        ImagemJogo.load(url: URL(string: imgUrl)!)
        ImagemJogo.layer.cornerRadius = 20
        
        metascore.layer.masksToBounds = true
        metascore.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        metascore.layer.borderWidth = 1.0
        
        metascore.layer.cornerRadius = metascore.frame.width/4
        
        metascore.text = "\(notaMeta)"
        
        if notaMeta == 0 {
            metascore.text = "🧐"
            metascore.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        } else if notaMeta > 0 && notaMeta < 50 {
            metascore.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        } else if notaMeta > 49 && notaMeta < 75 {
            metascore.backgroundColor = #colorLiteral(red: 1, green: 0.7716135383, blue: 0, alpha: 1)
        } else if notaMeta > 74 {
            metascore.backgroundColor = #colorLiteral(red: 0.1773776114, green: 0.8119599223, blue: 0, alpha: 1)
        }
        
        configureDropDown()
        
        print(metaURL)
    }
    
    func configureDropDown() {
        DropDown.appearance().setupCornerRadius(10)
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().selectedTextColor = UIColor.white
        DropDown.appearance().textFont = UIFont(name:"HelveticaNeue-Bold", size: 15)!
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = #colorLiteral(red: 0.00238864636, green: 0.4450881481, blue: 0.900737524, alpha: 1)
    }
    
    @objc func selecionaCategoria() {
        dropDown.show()
    }
    
    @IBAction func goToMetacritic(_ sender: Any) {
        if let url = URL(string: metaURL) {
            print(url)
            UIApplication.shared.open(url)
        }
    }
}
