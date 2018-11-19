//
//  MainWeatherCollectionViewCell.swift
//  YourWeather
//
//  Created by AlexanderKogut on 11/19/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import UIKit

class MainWeatherCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityWeather: UILabel!
    @IBOutlet weak var weatherTemperature: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
       self.backgroundColor = UIColor.SelectedColor.darkBlueGray
    }

}
