//
//  DegreesService.swift
//  YourWeather
//
//  Created by AlexanderKogut on 11/19/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import Foundation

class DegreesService {
    
    static func convertCelvitToC(celvin: Double) -> String {
       return String(format: "%.0f", celvin - 273.15) + " " + "C°"
    }
    
}
