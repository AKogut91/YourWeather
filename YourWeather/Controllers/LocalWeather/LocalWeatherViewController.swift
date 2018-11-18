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
        case CityLabel, CityWeater
    }
}

class LocalWeatherViewController: UIViewController {
    
    var localModel: LocalWeatherViewModel!
    @IBOutlet weak var tableView: UITableView!
    let cellSection: [CellType] = [.CityLabel, .CityWeater]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localModel = LocalWeatherViewModel(complition: {
            self.tableView.reloadData()
        })
        setTable()
    }
    
    func setTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CityLabelTableViewCell", bundle: nil), forCellReuseIdentifier: GlobalsCell.cityLabel)
    }
}

extension LocalWeatherViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let cellItems = cellSection[section]
        
        switch cellItems {
        case .CityLabel: return localModel.weaterTemp.count == 0 ? 0: 1
        case .CityWeater: return localModel.weaterTemp.count == 0 ? 0: localModel.weaterTemp.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellItems = cellSection[indexPath.section]
        
        switch cellItems {
        case .CityLabel:
            let cell = tableView.dequeueReusableCell(withIdentifier: GlobalsCell.cityLabel, for: indexPath) as! CityLabelTableViewCell
            cell.city.text = localModel.cityInfo.city.name
            cell.contry.text = localModel.cityInfo.city.country
            cell.numberOfPopulation.text = String(localModel.cityInfo.city.population)
            
            return cell
            
        case .CityWeater:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = localModel.weaterTemp[indexPath.row].main
            return cell
        }
    }
}

extension LocalWeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cellItems = cellSection[indexPath.section]
        
        switch cellItems {
        case .CityLabel: return 140
        case .CityWeater:return 80
        }
    }
}
