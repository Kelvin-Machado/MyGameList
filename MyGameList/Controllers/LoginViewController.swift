//
//  LoginViewController.swift
//  MyGameList
//
//  Created by Kelvin Batista Machado on 14/09/20.
//  Copyright © 2020 Kelvin Batista Machado. All rights reserved.
//

import UIKit
import ShimmerLabel
import SkyFloatingLabelTextField

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTxt: SkyFloatingLabelTextField!
    @IBOutlet weak var senhaTxt: SkyFloatingLabelTextField!
    
    @IBOutlet weak var buttonLembrarDados: UIButton!
    @IBOutlet weak var buttonEntrar: UIButton!
    @IBOutlet weak var buttonEsqueciSenha: UIButton!
    @IBOutlet weak var buttonCadastrarUsuario: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonEntrar.layer.cornerRadius = 25
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    @IBAction func buttonLembrarDadosPressed(_ sender: Any) {
        
        if buttonLembrarDados.isSelected {
            buttonLembrarDados.isSelected = false
        } else {
            buttonLembrarDados.isSelected = true
        }
    }
    
    @IBAction func buttonEntrarPressed(_ sender: Any) {
        print("Entrar!")
    }
    
}

