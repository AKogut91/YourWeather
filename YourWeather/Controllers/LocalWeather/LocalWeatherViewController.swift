//
//  LocalWeatherViewController.swift
//  YourWeather
//
//  Created by AlexanderKogut on 11/17/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import UIKit
import SVProgressHUD
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
    var addedCity = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.BackgroundColor.background
        SVProgressHUD.show()
        setNavigationRightButton()
        setTable()
        
        switch type {
        case RequestType.cityTitel.rawValue:
            return viewModel = LocalWeatherViewModel(city: currentCity, complition: {
                
            })
         
        case RequestType.cityCoordinate.rawValue:
            return viewModel = LocalWeatherViewModel(coordinate: coordinate, complition: {
            })
            
        default: print("")
        }
        
        self.tableView.reloadData()
        self.navigationTitel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SVProgressHUD.dismiss()
    }
}

//MARK: - Table
extension LocalWeatherViewController {
    
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

//MARK: - Navigation Right Bar Button Item
extension LocalWeatherViewController {
    
    func navigationTitel() {
        self.title = self.viewModel.currentCityWeather.name
    }
    
    func setNavigationRightButton() {
        
        if let navController = self.navigationController, navController.viewControllers.count >= 2 {
            let viewController = navController.viewControllers[navController.viewControllers.count - 2]
            NSLog("%@", viewController)
            
            if viewController.isKind(of: SelectCityWeatherViewController.self) {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addCityToDB))
            } else {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Delete"), style: UIBarButtonItem.Style.done, target: self, action: #selector(removeCityToDB))
            }
        }
    }
    
    @objc func pressBack() {
        
        if addedCity {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc func addCityToDB() {
        SVProgressHUD.showSuccess(withStatus: "Added")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            SVProgressHUD.dismiss()
        }
        
     addedCity = true
     viewModel.saveToDataBase(cityTitel: self.viewModel.currentCityWeather.name)
    }
    
    @objc func removeCityToDB() {
        SVProgressHUD.showSuccess(withStatus: "Removed")
        viewModel.removeObjFromDataBase(title: self.viewModel.currentCityWeather.name!)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.navigationController?.popToRootViewController(animated: true)
        }
    }
}

extension LocalWeatherViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.forecastWeather.count == 0 ? 0: 1
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
        case .CityLabel: return 330
        case .CityWeater:return 130
        case .WeatherFor16Days:return 207
        }
    }
}
