//
//  ColorsGradient.swift
//  MyGameList
//
//  Created by Kelvin Batista Machado on 15/09/20.
//  Copyright © 2020 Kelvin Batista Machado. All rights reserved.
//
import UIKit

class ColorsGradient: UIView {
    override open class var layerClass: AnyClass {
       return CAGradientLayer.classForCoder()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [#colorLiteral(red: 0.3481284976, green: 0.3531114459, blue: 0.3615698218, alpha: 1).cgColor, #colorLiteral(red: 0.1746657491, green: 0.1846371293, blue: 0.1887343824, alpha: 1).cgColor]
    }
}
