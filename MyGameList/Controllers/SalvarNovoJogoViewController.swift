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
    
//    func configureDropDownCategoria() {
//        categorias = Array(realm.objects(Categoria.self))
//        
//        dropDown.direction = .bottom
//        dropDownBtn.layer.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 0.6372538527)
//        dropDownBtn.layer.cornerRadius = 5
//        dropDownBtn.setTitle("  Categoria", for: .normal)
//        dropDownBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 18)
//        dropDownBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
//        dropDownBtn.addTarget(self, action: #selector(selecionaCategoria), for: .touchUpInside)
//        dropDownBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
//        DropDown.startListeningToKeyboard()
//        
//        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//            print("Selected item: \(item) at index: \(index)")
//            
//            
//            
//            self.dropDown.hide()
//            self.dropDownBtn.setTitle("  \(item)", for: .normal)
//            self.dropDownBtn.backgroundColor = #colorLiteral(red: 0.00238864636, green: 0.4450881481, blue: 0.900737524, alpha: 0.7036868579)
//            self.dropDownBtn.layer.cornerRadius = 5
//            self.dropDownBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
//            
//            self.categoriaSelecionada = item
//            
//            
//        }
//        
//        for categoria in categorias{
//            if categoria.tipo == .receita {
//                dropDown.dataSource.append(contentsOf: [categoria.descricao])
//            }
//        }
//        
//        containerView.addSubview(dropDownBtn)
//        dropDown.anchorView = dropDownBtn
//        dropDownBtn.translatesAutoresizingMaskIntoConstraints = false
//        dropDown.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            dropDownBtn.topAnchor.constraint(equalTo: valor.bottomAnchor, constant: 20),
//            dropDownBtn.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
//            dropDownBtn.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20)
//        ])
//        
//    }
    
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
