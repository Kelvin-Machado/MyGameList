//
//  UsuarioCard.swift
//  MyGameList
//
//  Created by Kelvin Batista Machado on 17/09/20.
//  Copyright © 2020 Kelvin Batista Machado. All rights reserved.
//

import UIKit

class UsuarioCard: UIView {

    @IBOutlet weak var nomeLbl: UILabel!
    @IBOutlet weak var totalJogosLbl: UILabel!
    
    @IBOutlet weak var imagem: UIImageView!
    
    @IBOutlet weak var buttomCard: UIButton!
    @IBAction func buttomPressed(_ sender: Any) {
        print("Botão de Usuário card pressionado")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        imagem.layer.cornerRadius = 45
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let _ = loadViewFromNib()
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "UsuarioCard", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
        return view
    }
}
