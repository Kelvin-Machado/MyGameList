//
//  MenuViewController.swift
//  MyGameList
//
//  Created by Kelvin Batista Machado on 16/09/20.
//  Copyright © 2020 Kelvin Batista Machado. All rights reserved.
//

import UIKit
import RealmSwift

class MenuViewController: UIViewController {
    
//        MARK: - Properties
    
    let realm = try! Realm()

    @IBOutlet weak var cardUsuario: UsuarioCard!
    @IBOutlet weak var meusJogosBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        cardUsuario.layer.cornerRadius = 10
        cardUsuario.layer.borderWidth = 3
        cardUsuario.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    @IBAction func meusJogosBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToMeusJogos", sender: self)
    }
    

}
