//
//  SelectCityWeatherViewController.swift
//  YourWeather
//
//  Created by AlexanderKogut on 11/18/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import UIKit

class SelectCityWeatherViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searhTabBar: UISearchBar!
    var searchingCity = [String]()
    var searching = false
    
    var viewModel: SelectCityWeatherViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select City"
        self.view.backgroundColor = UIColor.BackgroundColor.background
        
        viewModel = SelectCityWeatherViewModel(complition: {
            self.tableview.reloadData()
        })
        setTableView()
        setSearchTabBar()
    }
    
    func setTableView() {
        tableview.dataSource = self
        tableview.delegate = self
        tableview.backgroundColor = .clear
        tableview.separatorStyle = .none
    }
    
    func setSelectionViewForCell() -> UIView {
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.SelectedColor.darkBlueGray
        return bgColorView
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
}

extension SelectCityWeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching {
            return searchingCity.count
        } else {
            return viewModel.allCities.count == 0 ? 0 : viewModel.allCities.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if searching {
            cell.textLabel?.text = searchingCity[indexPath.row]
        } else {
            cell.textLabel?.text = viewModel.allCities[indexPath.row]
        }
    
        cell.textLabel?.textColor = .white
        cell.backgroundColor = UIColor.BackgroundColor.background
        cell.selectedBackgroundView = setSelectionViewForCell()
        return cell
    }
}

extension SelectCityWeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var city = ""
        
        if searching {
            
            city = searchingCity[indexPath.row]
            
        } else {
            
            city = viewModel.allCities[indexPath.row]
            
        }

        
        self.view.endEditing(true)
        let storyboard = UIStoryboard(name: "LocalWeather", bundle: nil)
        let newView = storyboard.instantiateViewController(withIdentifier: "LocalWeather") as? LocalWeatherViewController
        newView?.currentCity = city
        newView?.type = RequestType.cityTitel.rawValue
        newView!.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(newView!, animated: true)
    }
}

extension SelectCityWeatherViewController {
    
    func setSearchTabBar() {
        searhTabBar.delegate = self
        searhTabBar.barTintColor = UIColor.SelectedColor.darkBlueGray
        let textFieldAppearance = UITextField.appearance()
        textFieldAppearance.keyboardAppearance = .dark
        searhTabBar.setPlaceholderTextColorTo(color: UIColor.white)

    }
}

extension SelectCityWeatherViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchingCity = viewModel.allCities.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableview.reloadData()
    }

}



