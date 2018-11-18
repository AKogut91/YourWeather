//
//  CityLabelTableViewCell.swift
//  YourWeather
//
//  Created by AlexanderKogut on 11/17/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import UIKit

class CityLabelTableViewCell: UITableViewCell {

    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var contry: UILabel!
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var numberOfPopulation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
}
