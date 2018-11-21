//
//  CityLabelTableViewCell.swift
//  YourWeather
//
//  Created by AlexanderKogut on 11/17/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import UIKit

class CityLabelTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherIMage: UIImageView!
    @IBOutlet weak var weatherDegrees: ProjectLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        
        
    }
}
