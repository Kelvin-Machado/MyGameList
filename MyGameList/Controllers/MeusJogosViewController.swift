//
//  MeusJogosViewController.swift
//  MyGameList
//
//  Created by Kelvin Batista Machado on 17/09/20.
//  Copyright © 2020 Kelvin Batista Machado. All rights reserved.
//

import UIKit

struct CustomData {
    var title: String
    var url: String
    var backgroundImage: UIImage
}

class MeusJogosViewController: UIViewController {

    fileprivate let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 20
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "PlafatormaCell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCV()
    }
    
    func configureCV() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: view.frame.height/2).isActive = true
    }
    
    @IBAction func backToMenu(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}

extension MeusJogosViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2.5, height: view.frame.height/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlafatormaCell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}
