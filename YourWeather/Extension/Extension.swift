//
//  Extension.swift
//  YourWeather
//
//  Created by AlexanderKogut on 11/18/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    struct BackgroundColor {
        
        static var background: UIColor {
            return UIColor(red: 25/255.0, green: 29/255.0, blue: 32/255.0, alpha: 1.0)
        }
    }
    
    struct SelectedColor {
        
        static var darkBlueGray : UIColor {
            return UIColor(red: 31/255.0, green: 36/255.0, blue: 39/255.0, alpha: 1.0)
        }
        
        static var orange : UIColor {
            return UIColor(red: 245/255.0, green: 130/255.0, blue: 35/255.0, alpha: 1.0)
        }
    }
    
}

extension UISearchBar {
    
    func setPlaceholderTextColorTo(color: UIColor) {
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = UIColor.BackgroundColor.background
        textFieldInsideSearchBar?.placeholder = "Search"
        textFieldInsideSearchBar?.textColor = color
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = color
    }
}


