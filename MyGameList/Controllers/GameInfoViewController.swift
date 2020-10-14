//
//  GameInfoViewController.swift
//  MyGameList
//
//  Created by Kelvin Batista Machado on 13/10/20.
//  Copyright © 2020 Kelvin Batista Machado. All rights reserved.
//

import UIKit

class GameInfoViewController: UIViewController {
    
    

    @IBOutlet weak var gameTitleLbl: UILabel!
    @IBOutlet weak var gameImg: UIImageView!
    @IBOutlet weak var gameDescTxt: UITextView!
    
    var nomejogo = ""
    var imagem = ""
    var desc = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameTitleLbl.text = nomejogo
        gameTitleLbl.layer.cornerRadius = 10
        gameTitleLbl.layer.masksToBounds = true
        gameImg.load(url: URL(string: imagem)!)
        gameImg.backgroundColor = .clear
        gameImg.layer.cornerRadius = 30
        gameDescTxt.text = desc
    }

}
