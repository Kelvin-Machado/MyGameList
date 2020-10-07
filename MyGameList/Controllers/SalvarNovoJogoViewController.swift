//
//  SalvarNovoJogoViewController.swift
//  MyGameList
//
//  Created by Kelvin Batista Machado on 25/09/20.
//  Copyright © 2020 Kelvin Batista Machado. All rights reserved.
//

import UIKit
import DropDown
import RealmSwift
import Alamofire

class SalvarNovoJogoViewController: UIViewController {
    
    //    MARK: - Properties
    let realm = try! Realm()
    
    @IBOutlet weak var nomeJogo: UILabel!
    @IBOutlet weak var ImagemJogo: UIImageView!
    @IBOutlet weak var metascore: UILabel!
    @IBOutlet weak var metacritic: UIButton!
    
    let saveBtn = UIButton()
    var parentSave = [GameParentPlatform]()
    var platformSave = [GamePlatform]()
    var myGameSave = [MyGame]()
    var saveData = MyGameToSave()
    
    typealias ParentPlatforms = (parentplatformId: Int, parentName: String, platformId: Int, platformName: String)
    var platformsTupleArray = [ParentPlatforms]()
    
    var nome = ""
    var imgUrl = ""
    var notaMeta = 0
    var metaURL = ""
    var gameID = 0
    var descriptionGame = ""
    var releasedDate = Date()
    var imgUrlCover = ""
    
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
        fetchNumberChildPlatforms()
        
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
        print("Save pressed, data to save: \(saveData.platformProperties.namePlatform)")
        saveData.gameProperties.id = gameID
        saveData.gameProperties.name = nome
        saveData.gameProperties.gameDescription = descriptionGame
        saveData.gameProperties.released = releasedDate
        saveData.gameProperties.metacritic = notaMeta
        saveData.gameProperties.backgroundImage = imgUrlCover
        
        for index in 0...platformsTupleArray.count-1 {
            if saveData.platformProperties.namePlatform == platformsTupleArray[index].platformName {
                saveData.parentProperties.id = platformsTupleArray[index].parentplatformId
                saveData.parentProperties.nameParentPlatform = platformsTupleArray[index].parentName
                saveData.platformProperties.id = platformsTupleArray[index].platformId
                saveData.platformProperties.namePlatform = platformsTupleArray[index].platformName
            }
        }
        
        save(saveData: saveData)
    }
    
    func save(saveData: MyGameToSave) {
        print("SAVE DATA")
        let sucesso = true
        do {
            if let parent = realm.objects(GameParentPlatform.self).filter("id = \(saveData.parentProperties.id)").first  {
                if let platform = realm.objects(GamePlatform.self).filter("id = \(saveData.platformProperties.id)").first {
                    try realm.write {
                        
                        realm.add(saveData.gameProperties, update: .modified)
                        platform.myGames.append(saveData.gameProperties)
                        showAlert(sucesso: sucesso)
                    }
                
                } else {
                    try realm.write {
                        realm.add(saveData.platformProperties)
                        parent.childPlatforms.append(saveData.platformProperties)
                    }
                    save(saveData: saveData)
                }
            } else {
                try realm.write {
                    realm.add(saveData.parentProperties)
                }
                save(saveData: saveData)
            }
        } catch {
            print("Error saving game \(error)")
            showAlert(sucesso: !sucesso)
            
        }
    }
    
    func showAlert(sucesso: Bool) {
        var msg = ""
        var titulo = ""
        sucesso ? (msg = "Jogo Salvo") : (msg = "Ocorreu um erro")
        sucesso ? (titulo = "Sucesso!!!") : (titulo = "Erro")
        let alert = UIAlertController(title: titulo, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                        switch action.style {
                                        case .default:
                                            self.dismiss(animated: true, completion: nil)
                                            
                                        case .cancel:
                                            print("cancel")
                                            
                                        case .destructive:
                                            print("destructive")
                                            
                                        @unknown default:
                                            fatalError()
                                        }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func goToMetacritic(_ sender: Any) {
        if let url = URL(string: metaURL) {
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
            
            saveData.platformProperties.namePlatform = item
            
            self.dropDown.hide()
            self.dropDownBtn.setTitle("  \(item)", for: .normal)
            self.dropDownBtn.backgroundColor = #colorLiteral(red: 0.00238864636, green: 0.4450881481, blue: 0.900737524, alpha: 0.7036868579)
            self.dropDownBtn.layer.cornerRadius = 5
            self.dropDownBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.plataformaSelecionada = item
            
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

// Request
extension SalvarNovoJogoViewController {
    func fetchNumberChildPlatforms() {
        if self.dropDown.dataSource.isEmpty {
            let request = AF.request("https://api.rawg.io/api/platforms/lists/parents")
            
            request.responseDecodable(of: ParentsList.self) { [self] (response) in
                guard let parents = response.value else { return }
                
                for parentIndex in 0...parents.count-1 {
                    for parentPlatformIdsIndex in 0...self.parentplatformsIds.count-1 {
                        
                        if parents.results[parentIndex].id == self.parentplatformsIds[parentPlatformIdsIndex] {
                            
                            let numPlatParent = parents.results[parentIndex].platforms.count-1
                            
                            for index in 0...numPlatParent {
                                for parentPlatResultIndex in 0...self.platformsIds.count-1{
                                    
                                    if parents.results[parentIndex].platforms[index].id == self.platformsIds[parentPlatResultIndex] {
                                        
                                        let parentPlatforms = ParentPlatforms(parentplatformId: parents.results[parentIndex].id, parentName: parents.results[parentIndex].name, platformId: parents.results[parentIndex].platforms[index].id, platformName: parents.results[parentIndex].platforms[index].name)
                                        
                                        platformsTupleArray.append(parentPlatforms)
                                        
                                        self.dropDown.dataSource.append(contentsOf: [parents.results[parentIndex].platforms[index].name])
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
        } else {
            self.dropDown.dataSource.removeAll()
            fetchNumberChildPlatforms()
        }
    }
}
