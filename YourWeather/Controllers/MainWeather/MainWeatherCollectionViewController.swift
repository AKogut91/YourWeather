//
//  MainWeatherCollectionViewController.swift
//  YourWeather
//
//  Created by AlexanderKogut on 11/18/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import UIKit
import CoreLocation

private let reuseIdentifier = "Cell"

class MainWeatherCollectionViewController: UICollectionViewController {
    
    let locationManager = CLLocationManager()
    var coordinate = [String: Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        self.title = "Cities"
        setCollection()
        transparentNavigationBar()
        registerCell()
        layout()
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
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: GlobalsCell.mainWeatherCell, for: indexPath) as! MainWeatherCollectionViewCell
        
        return cell
    }
}

//MARK: - CollectionView Settings
extension MainWeatherCollectionViewController {
    
    func registerCell() {
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
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

//MARK: - Navigation Bar
extension MainWeatherCollectionViewController {
    
    /// Transparent navigation bar ios
    func transparentNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController!.navigationBar.tintColor = UIColor.white
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