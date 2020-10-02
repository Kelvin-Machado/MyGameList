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
    
    let saveBtn = UIButton()
    
    var nome = ""
    var imgUrl = ""
    var notaMeta = 0
    var metaURL = ""
    
    var parentplatformsIds = [Int]()
    var platformsIds = [Int]()
    var plataformaSelecionada = ""
    
    let dropDown = DropDown()
    var dropDownBtn = UIButton()
    
    var containerView:UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ViewDidLoad Salvar")
        print("Parent IDs: \(self.parentplatformsIds)")
        print("Platforms IDs: \(self.platformsIds)")
        
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
        configureContainer()
        configureDropDown()
        configureDropDownPlataforma()
        configureSaveBtn()
        print(metaURL)
    }
    
    func configureContainer() {
        
        containerView.backgroundColor = #colorLiteral(red: 0.1746657491, green: 0.1846371293, blue: 0.1887343824, alpha: 0.7021885702)
        containerView.layer.cornerRadius = 5
        
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: metacritic.bottomAnchor, constant: 10),
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
    
    
      //    MARK: - Configure buttons
      
      func configureSaveBtn() {
        
        saveBtn.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
        saveBtn.setTitleColor(UIColor.white, for:UIControl.State.normal)
        saveBtn.titleLabel?.font = UIFont (name: "HelveticaNeue-Bold", size: 20)
        saveBtn.layer.cornerRadius = 30
        saveBtn.tintColor = .white
        saveBtn.setTitle("Salvar", for: .normal)
          saveBtn.addTarget(self, action: #selector(self.saveButtonPressed), for: .touchUpInside)
          
          containerView.addSubview(saveBtn)
          
          saveBtn.translatesAutoresizingMaskIntoConstraints = false
          
          NSLayoutConstraint.activate([
              saveBtn.topAnchor.constraint(equalTo: dropDownBtn.bottomAnchor, constant: 20),
              saveBtn.heightAnchor.constraint(equalToConstant: 60),
              saveBtn.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
              saveBtn.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20)
          ])
      }
      @objc func saveButtonPressed() {
        print("Save pressed")
      }
    
    
    @IBAction func goToMetacritic(_ sender: Any) {
        if let url = URL(string: metaURL) {
            print(url)
            UIApplication.shared.open(url)
        }
    }
}

//MARK: - DropDown Menu

extension SalvarNovoJogoViewController {
    
    func configureDropDown() {
        DropDown.appearance().setupCornerRadius(10)
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().selectedTextColor = UIColor.white
        DropDown.appearance().textFont = UIFont(name:"HelveticaNeue-Bold", size: 15)!
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = #colorLiteral(red: 0.00238864636, green: 0.4450881481, blue: 0.900737524, alpha: 1)
    }
    
    func configureDropDownPlataforma() {
        
        dropDown.direction = .bottom
        dropDownBtn.layer.backgroundColor = #colorLiteral(red: 0.997867167, green: 0.8090524077, blue: 0.2110246718, alpha: 1)
        dropDownBtn.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        dropDownBtn.layer.borderWidth = 1.5
        dropDownBtn.layer.cornerRadius = 5
        dropDownBtn.setTitle("  Plataformas", for: .normal)
        dropDownBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 18)
        dropDownBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        dropDownBtn.addTarget(self, action: #selector(selecionaCategoria), for: .touchUpInside)
        dropDownBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        DropDown.startListeningToKeyboard()
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            
            
            self.dropDown.hide()
            self.dropDownBtn.setTitle("  \(item)", for: .normal)
            self.dropDownBtn.backgroundColor = #colorLiteral(red: 0.00238864636, green: 0.4450881481, blue: 0.900737524, alpha: 0.7036868579)
            self.dropDownBtn.layer.cornerRadius = 5
            self.dropDownBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.plataformaSelecionada = item
            
            
        }
        for index in 0...platformsIds.count-1 {
            dropDown.dataSource.append(contentsOf: [String(platformsIds[index])])
        }
        
        containerView.addSubview(dropDownBtn)
        dropDown.anchorView = dropDownBtn
        dropDownBtn.translatesAutoresizingMaskIntoConstraints = false
        dropDown.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dropDownBtn.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            dropDownBtn.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            dropDownBtn.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20)
        ])
        
    }
    
    @objc func selecionaCategoria() {
        dropDown.show()
    }
}
