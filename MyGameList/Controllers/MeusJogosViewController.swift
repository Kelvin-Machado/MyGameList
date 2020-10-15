//
//  MeusJogosViewController.swift
//  MyGameList
//
//  Created by Kelvin Batista Machado on 17/09/20.
//  Copyright © 2020 Kelvin Batista Machado. All rights reserved.
//

import UIKit
import RealmSwift
import iCarousel

class MeusJogosViewController: UIViewController {
    
    //    MARK: - Properties
    
    let realm = try! Realm()
    var parentSelected = ""
    
    var parents: RealmSwift.Results<GameParentPlatform>?
    let myCarousel: iCarousel = {
        let view = iCarousel()
        view.type = .rotary
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        loadCarousel()
    }
    
    func loadCarousel() {
        
        parents = realm.objects(GameParentPlatform.self)
        view.addSubview(myCarousel)
        myCarousel.dataSource = self
        myCarousel.autoscroll = 0.1
        myCarousel.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height * 0.75)
        
    }
    
    @IBAction func backToMenu(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension MeusJogosViewController: iCarouselDataSource, iCarouselDelegate {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return parents?.count ?? 0
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width * 0.75, height: self.view.frame.size.height * 0.75))
        view.backgroundColor = .clear
        
        let imageview = UIImageView(frame: view.bounds)
        view.addSubview(imageview)
        imageview.contentMode = .scaleAspectFit
        
        for i in 0...parentsCover.allCases.count-1 {
            if parents?[index].nameParentPlatform == parentsCover.allCases[i].description {
                imageview.image = parentsCover.allCases[i].image
            }
        }
        
        view.isUserInteractionEnabled = true

        let tapGesture = UITapGestureRecognizer(target: self , action: #selector(toque))
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
        
        return view
    }
    
    @objc func toque() {
        parentSelected = parents![myCarousel.currentItemIndex].nameParentPlatform
        self.performSegue(withIdentifier: "goToGamesTable", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToGamesTable"){
                let displayVC = segue.destination as! GamesTableViewController
            displayVC.parentName = parents![myCarousel.currentItemIndex].nameParentPlatform
            displayVC.parents = parents
        }
    }
}
