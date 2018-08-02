//
//  ColorPickerForLanguage.swift
//  GitHub
//
//  Created by Alexander Griswold on 8/2/18.
//  Copyright © 2018 com.MobilePic. All rights reserved.
//

import UIKit

class ColorPickerForLanguage {
    func pickColor(language: String) -> UIColor {
        switch language {
        case "Swift":
            return UIColor.orange
        case "JavaScript":
            return UIColor.blue
        case "Objective-C":
            return UIColor.cyan
        case "Python":
            return UIColor.red
        case "C++":
            return UIColor.green
        case "C":
            return UIColor.purple
        default:
            return UIColor.black
        }
    }
}
