//
//  plataformas.swift
//  MyGameList
//
//  Created by Kelvin Batista Machado on 15/09/20.
//  Copyright © 2020 Kelvin Batista Machado. All rights reserved.
//

import UIKit

enum parentsCover: String, CustomStringConvertible, CaseIterable {
    
    case pc
    case playstation
    case xbox
    case iOS
    case android
    case appleMacintosh
    case linux
    case nintendo
    case atari
    case comodore
    case sega
    case threedo
    case neogeo
    case web
    
    static var count: Int { return parentsCover.web.hashValue + 1}
    
    var description: String {
        switch self {
        case .pc: return "PC"
        case .playstation: return "PlayStation"
        case .xbox: return "Xbox"
        case .iOS: return "iOS"
        case .android: return "Android"
        case .appleMacintosh: return "Apple Macintosh"
        case .linux: return "Linux"
        case .nintendo: return "Nintendo"
        case .atari: return "Atari"
        case .comodore: return "Commodore / Amiga"
        case .sega: return "SEGA"
        case .threedo: return "3DO"
        case .neogeo: return "Neo Geo"
        case .web: return "Web"
        
        }
    }
    var image: UIImage {
        switch self {
        case .pc: return #imageLiteral(resourceName: "logo-PC")
        case .playstation: return #imageLiteral(resourceName: "logo-Cover-PlayStation")
        case .xbox: return #imageLiteral(resourceName: "logo-XBOX")
        case .iOS: return #imageLiteral(resourceName: "ios-logo")
        case .android: return #imageLiteral(resourceName: "logo-android")
        case .appleMacintosh: return #imageLiteral(resourceName: "loc-macos")
        case .linux: return #imageLiteral(resourceName: "logo-linux")
        case .nintendo: return #imageLiteral(resourceName: "logo-nintendo")
        case .atari: return #imageLiteral(resourceName: "logo-atari")
        case .comodore: return #imageLiteral(resourceName: "logo-comodore")
        case .sega: return #imageLiteral(resourceName: "logo-sega")
        case .threedo: return #imageLiteral(resourceName: "logo-3do")
        case .neogeo: return #imageLiteral(resourceName: "logo-neogeo")
        case .web: return #imageLiteral(resourceName: "logo-web")
        
        }
    }
}

enum Consoles: String, CustomStringConvertible {
    
    case playstation1
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
        case .playstation1: return "PlayStation"
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
        case .playstation1: return #imageLiteral(resourceName: "logo-PS1")
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
