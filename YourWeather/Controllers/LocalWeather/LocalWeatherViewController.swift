//
//  LocalWeatherViewController.swift
//  YourWeather
//
//  Created by AlexanderKogut on 11/17/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import UIKit
import CoreData
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
    var cityName = false
    var addedCity = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.BackgroundColor.background
        SVProgressHUD.show()
        setNavigationRightButton()
        setTable()
        print(coordinate)
        
        switch type {
        case RequestType.cityTitel.rawValue:
            return viewModel = LocalWeatherViewModel(city: currentCity, complition: {
                SVProgressHUD.dismiss()
                self.reloadTableView()
                self.navigationTitel()
                
            })
         
        case RequestType.cityCoordinate.rawValue:
            return viewModel = LocalWeatherViewModel(coordinate: coordinate, complition: {
                SVProgressHUD.dismiss()
                self.reloadTableView()
                self.navigationTitel()
            })
            
        default: print("")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SVProgressHUD.dismiss()
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

//MARK: - Right Bar Button Item
extension LocalWeatherViewController {
    
    func setNavigationRightButton() {
        
        if cityName {
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Delete"), style: UIBarButtonItem.Style.done, target: self, action: #selector(removeCityToDB))
            
        } else {
            
             self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addCityToDB))
        }
    }
    
    @objc func pressBack() {
        
        if addedCity {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc func addCityToDB() {
        SVProgressHUD.showSuccess(withStatus: "Added")
        SVProgressHUD.setMinimumDismissTimeInterval(2)
     addedCity = true
     viewModel.saveToDataBase(cityTitel: self.viewModel.currentCityWeather.name)
    }
    
    @objc func removeCityToDB() {
        SVProgressHUD.showSuccess(withStatus: "Removed")
        SVProgressHUD.setMinimumDismissTimeInterval(2)
       remove(title: self.viewModel.currentCityWeather.name!)
    }
    
    func remove(title: String) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: DataBaseService.entity.City.rawValue)
        let predicate = NSPredicate(format: "cityName == %@", title)
        request.predicate = predicate
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        deleteRequest.resultType = .resultTypeObjectIDs
        
        do {
            // Executes batch
            try DataBaseService.shered.context.execute(deleteRequest) as? NSBatchDeleteResult
        } catch {
            fatalError("Failed to execute request: \(error)")
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
        case .CityLabel: return 310
        case .CityWeater:return 166
        case .WeatherFor16Days:return GlobalSize.screenHeight / 6.13
        }
    }
}
