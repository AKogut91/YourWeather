//
//  CityTemperatureTableViewCell.swift
//  YourWeather
//
//  Created by AlexanderKogut on 11/17/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import UIKit

class CityTemperatureTableViewCell: UITableViewCell {
    
   @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: LocalWeatherViewModel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setCollection()
        layout()
        
    }
    
    func configure(viewModel:LocalWeatherViewModel) {
        self.viewModel = viewModel
        collectionView.reloadData()
    }
}

//MARK: - Collestion Stuff
extension CityTemperatureTableViewCell {
    
    func setCollection() {
        collectionView.backgroundColor =  UIColor.BackgroundColor.background
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: GlobalsCell.collectionViewID)
        
    }
    
    func layout() {
        
        let cellWidth : CGFloat = (GlobalSize.screenWitdh / 3) - 10
        let cellheight : CGFloat = (GlobalSize.screenWitdh / 3) - 10
        let cellSize = CGSize(width: cellWidth , height:cellheight)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 5.0
        self.collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    
    
}

extension CityTemperatureTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.forecastWeather.count == 0 ? 0 : viewModel.forecastWeather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GlobalsCell.collectionViewID, for: indexPath as IndexPath) as! CollectionViewCell
            viewModel.configurCell(cell: cell, indexPath: indexPath)
        return cell
    }
}

extension CityTemperatureTableViewCell: UICollectionViewDelegate {

}
