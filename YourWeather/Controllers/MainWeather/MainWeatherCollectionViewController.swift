//
//  MainWeatherCollectionViewController.swift
//  YourWeather
//
//  Created by AlexanderKogut on 11/18/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import UIKit
import CoreLocation

class MainWeatherCollectionViewController: UICollectionViewController {
    
    var viewModel: MainWeatherViewModel!
    let locationManager = CLLocationManager()
    var coordinate = [String: Any]()
    var seletedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setTranspertBar(titleColor: .white, tinColor: .white)
        viewModel = MainWeatherViewModel()
        setupLocationManager()
        self.title = "Cities"
        setCollection()
        
        registerCell()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadFromDataBase()
        self.collectionView.reloadData()
    }
    
    func setCollection() {
        
        self.view.backgroundColor = UIColor.BackgroundColor.background
        self.collectionView.backgroundColor = .clear
        collectionView.register(UINib(nibName: "MainWeatherCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: GlobalsCell.mainWeatherCell)
        
    }

    @IBAction func showSerchVC(_ sender: Any) {
     
        let storyboard = UIStoryboard(name: "SelectCityWeather", bundle: nil)
        let newView = storyboard.instantiateViewController(withIdentifier: "SelectCityWeather") as? SelectCityWeatherViewController
        newView!.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(newView!, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "coordinate"{
            let vc = segue.destination as! LocalWeatherViewController
            vc.coordinate = coordinate
            vc.type = RequestType.cityCoordinate.rawValue
        }
    }
    
    @IBAction func showWeatherByCoordinate(_ sender: Any) {
        performSegue(withIdentifier: "coordinate", sender: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.citys.count == 0 ? 0 : viewModel.citys.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: GlobalsCell.mainWeatherCell, for: indexPath) as! MainWeatherCollectionViewCell
    
        let databaseValue = viewModel.citys[indexPath.row]
            cell.cityWeather.text = databaseValue.cityName
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        seletedIndex = indexPath.row
        let cellData = viewModel.citys[indexPath.row]
        let city = cellData.cityName!
        
        let storyboard = UIStoryboard(name: "LocalWeather", bundle: nil)
        let newView = storyboard.instantiateViewController(withIdentifier: "LocalWeather") as? LocalWeatherViewController
        newView?.currentCity = city
        newView?.type = RequestType.cityTitel.rawValue
        newView!.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(newView!, animated: true)
    }
}

extension MainWeatherCollectionViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            coordinate["lat"] = lat
            coordinate["lon"] = lon
            collectionView.reloadData()
            
            print(lat)
            print(lon)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

//MARK: - CollectionView Settings
extension MainWeatherCollectionViewController {
    
    func registerCell() {
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: GlobalsCell.cell)
    }
    
    /// Layout for 3 Cell
    func layout() {
        
        let cellWidth : CGFloat = (GlobalSize.screenWitdh / 3) - 10
        let cellheight : CGFloat = (GlobalSize.screenWitdh / 3) - 10
        let cellSize = CGSize(width: cellWidth , height:cellheight)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 5.0
        self.collectionView.setCollectionViewLayout(layout, animated: true)
        
    }
}

//MARK: - Localiton Setup
extension MainWeatherCollectionViewController {

    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}
