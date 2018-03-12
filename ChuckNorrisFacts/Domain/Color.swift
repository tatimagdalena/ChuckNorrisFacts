//
//  Color.swift
//  ChuckNorrisFacts
//
//  Created by Tatiana Magdalena on 12/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation

enum Color {
    case darkGray
    case blue
    
    var hexString: String {
        switch self {
        case .darkGray: return "#5C666A"
        case .blue: return "#47B2D9"
        }
    }
}
