//
//  MenuViewController.swift
//  MyGameList
//
//  Created by Kelvin Batista Machado on 16/09/20.
//  Copyright © 2020 Kelvin Batista Machado. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var cardUsuario: UsuarioCard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardUsuario.layer.cornerRadius = 10
        cardUsuario.layer.borderWidth = 3
        cardUsuario.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }

}
