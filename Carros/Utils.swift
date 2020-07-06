//
//  Utils.swift
//  Carros
//
//  Created by Marcelo Block Teixeira on 05/07/20.
//  Copyright © 2020 Marcelo Block Teixeira. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    func placeHolderTextWithColor (placeHolderTextLabel: String) -> NSAttributedString {
        let color: UIColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
                   let placeHolderText = NSAttributedString(string: placeHolderTextLabel,
                                                               attributes: [NSAttributedString.Key.foregroundColor: color
                                                               ])
                   
                   return placeHolderText
    }
}
