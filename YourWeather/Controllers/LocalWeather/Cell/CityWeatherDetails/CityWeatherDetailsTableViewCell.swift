//
//  CityWeatherDetailsTableViewCell.swift
//  YourWeather
//
//  Created by AlexanderKogut on 11/19/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import UIKit

class CityWeatherDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var sunriceImage: UIImageView!
    @IBOutlet weak var sunriceTime: UILabel!
    @IBOutlet weak var sunsetImage: UIImageView!
    @IBOutlet weak var sunsetTime: UILabel!
    @IBOutlet weak var windImage: UIImageView!
    @IBOutlet weak var windSpeed: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }

    func configure(viewModel: LocalWeatherViewModel) {
    
        if let weather = viewModel.currentCityWeather {
            
            windSpeed.text = String(weather.wind.speed) + " " + "M/s"
            sunriceTime.text = DateService.timeStamp(unixTimestamp: weather.sys.sunrise, timeFormat: .hoursMinut)
            sunsetTime.text = DateService.timeStamp(unixTimestamp: weather.sys.sunset, timeFormat: .hoursMinut)
            
        }
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
