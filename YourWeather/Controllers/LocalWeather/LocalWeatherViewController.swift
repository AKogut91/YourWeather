//
//  LocalWeatherViewController.swift
//  YourWeather
//
//  Created by AlexanderKogut on 11/17/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import UIKit
import HandyJSON

extension LocalWeatherViewController {
    
    enum CellType {
        case CityLabel, CityWeater, WeatherFor16Days
    }
}

enum RequestType: String {
    case cityTitel, cityCoordinate
}

class LocalWeatherViewController: UIViewController {
    
    private var viewModel: LocalWeatherViewModel!
    @IBOutlet weak var tableView: UITableView!
    private let cellSection: [CellType] = [.CityLabel, .CityWeater, .WeatherFor16Days]
    var currentCity = ""
    var type = ""
    var coordinate = [String: Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.BackgroundColor.background
        setTable()
        
        print(coordinate)
        
        switch type {
        case RequestType.cityTitel.rawValue:
            return viewModel = LocalWeatherViewModel(city: currentCity, complition: {
                self.reloadTableView()
                self.navigationTitel()
                
            })
         
        case RequestType.cityCoordinate.rawValue:
            return viewModel = LocalWeatherViewModel(coordinate: coordinate, complition: {
                self.reloadTableView()
                self.navigationTitel()
            })
            
        default: print("")
        }
        
    }
    
    func navigationTitel() {
        self.title = self.viewModel.currentCityWeather.name
    }
    
    func reloadTableView() {
        self.tableView.reloadData()
    }
    
    func setTable() {
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "CityLabelTableViewCell", bundle: nil), forCellReuseIdentifier: GlobalsCell.cityLabel)
        tableView.register(UINib(nibName: "CityTemperatureTableViewCell", bundle: nil), forCellReuseIdentifier: GlobalsCell.weatherFor16)
        tableView.register(UINib(nibName: "CityWeatherDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: GlobalsCell.cityWeatherDetails)
        
    }
}

extension LocalWeatherViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let cells = viewModel.forecastWeather.count == 0 ? 0: 1
        
        let cellItems = cellSection[section]
        switch cellItems {
        case .CityLabel:return cells
        case .CityWeater:  return cells
        case .WeatherFor16Days: return cells
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellItems = cellSection[indexPath.section]
        
        switch cellItems {
        case .CityLabel:
            let cell = tableView.dequeueReusableCell(withIdentifier: GlobalsCell.cityLabel, for: indexPath) as! CityLabelTableViewCell
            viewModel.configurCell(cell: cell, indexPath: indexPath)
            return cell
            
        case .CityWeater:
            let cell = tableView.dequeueReusableCell(withIdentifier: GlobalsCell.cityWeatherDetails, for: indexPath) as! CityWeatherDetailsTableViewCell
            cell.configure(viewModel: viewModel)
            
            return cell
            
        case .WeatherFor16Days:
            let cell = tableView.dequeueReusableCell(withIdentifier: GlobalsCell.weatherFor16, for: indexPath) as! CityTemperatureTableViewCell
            cell.configure(viewModel: viewModel)
            
            return cell
        }
    }
}

extension LocalWeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        let cellItems = cellSection[indexPath.section]
        switch cellItems {
        case .CityLabel: return GlobalSize.screenHeight / 2.3
        case .CityWeater:return GlobalSize.screenHeight / 3.5
        case .WeatherFor16Days:return GlobalSize.screenHeight / 6.13
        }
    }
}
