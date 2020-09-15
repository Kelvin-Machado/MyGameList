//
//  plataformas.swift
//  MyGameList
//
//  Created by Kelvin Batista Machado on 15/09/20.
//  Copyright © 2020 Kelvin Batista Machado. All rights reserved.
//

import UIKit

enum Consoles: String, CustomStringConvertible {
    
    case playstation
    case playstation2
    case playstation3
    case playstation4
    case psp
    case wii
    case wiiU
    case nds
    case gb
    case pc
    case vita
    case xbox
    
    var description: String {
        switch self {
        case .playstation: return "PlayStation"
        case .playstation2: return "PlayStation 2"
        case .playstation3: return "PlayStation 3"
        case .playstation4: return "PlayStation 4"
        case .psp: return "PSP"
        case .wii: return "Wii"
        case .wiiU: return "Wii U"
        case .nds: return "Nintendo DS"
        case .gb: return "Game Boy"
        case .pc: return "PC"
        case .vita: return "PlayStation Vita"
        case .xbox: return "XBOX"
        }
    }
    
    var image: UIImage {
        switch self {
        case .playstation: return #imageLiteral(resourceName: "logo-PS1")
        case .playstation2: return #imageLiteral(resourceName: "logo-PS2")
        case .playstation3: return #imageLiteral(resourceName: "logo-PS3")
        case .playstation4: return #imageLiteral(resourceName: "logo-PS4")
        case .psp: return #imageLiteral(resourceName: "logo-PSP")
        case .wii: return #imageLiteral(resourceName: "logo-Wii")
        case .wiiU: return #imageLiteral(resourceName: "logo-Wii-U")
        case .nds: return #imageLiteral(resourceName: "logo-NDS")
        case .gb: return #imageLiteral(resourceName: "logo-GB")
        case .pc: return #imageLiteral(resourceName: "logo-PC")
        case .vita: return #imageLiteral(resourceName: "logo-Vita")
        case .xbox: return #imageLiteral(resourceName: "logo-XBOX")
        }
    }
}
