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
    var platforms = [GamePlatform]()

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
        platforms = Array(realm.objects(GamePlatform.self))
        
        if platforms.count > 0 {
            performSegue(withIdentifier: "goToMeusJogos", sender: self)
        } else {
            showAlert()
        }
        
    }
    
    func showAlert() {
        let msg = "\n\n Sem jogos cadastrados. \n\n Por favor, adicione um jogo antes de acessar essa área"
        let alert = UIAlertController(title: "Erro", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
              switch action.style {
              case .default:
                    print("default")

              case .cancel:
                    print("cancel")

              case .destructive:
                    print("destructive")

              @unknown default:
                fatalError()
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    

}
