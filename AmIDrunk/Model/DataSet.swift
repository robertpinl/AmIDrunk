//
//  DataSet.swift
//  AmIDrunk
//
//  Created by Robert Pinl on 14.02.2021.
//

import Foundation

class DataSet {
    // Drinks available to calculate
    let categories = [
        DrinkChooseModel(title: "Beer", imageName: "beerDeselected", selectedImage: "beerSelected"),
        DrinkChooseModel(title: "Vine", imageName: "vineDeselected", selectedImage: "vineSelected"),
        DrinkChooseModel(title: "Cider", imageName: "ciderDeselected", selectedImage: "ciderSelected"),
        DrinkChooseModel(title: "Liquor", imageName: "shotDeselected", selectedImage: "shotSelected")
    ]
    
    //MARK: - Beers
    let beerSize: [Double] = [0.2, 0.3, 0.5, 0.6, 1]
    let beerSizeOz: [Double] = [6,12, 16, 24, 40]
    let beerVolume: [Double] = [4, 5, 6, 7, 8, 9]
    
    //MARK: - Wine
    let wineSize: [Double] = [0.2, 0.5, 0.7, 1, 1.5]
    let wineSizeOz: [Double] = [5, 25, 40]
    let wineVolume: [Double] = [9, 12, 15, 17, 19, 20, 25, 30]
    
    //MARK: - Cider
    let ciderSize: [Double] = [0.2, 0.3, 0.5, 0.6, 1]
    let ciderSizeOz: [Double] = [6, 12, 16, 24, 40]
    let ciderVolume: [Double] = [4, 5, 6]
    
    //MARK: - Liquor
    let liquorSize: [Double] = [0.02, 0.04, 0.05, 0.1, 0.2, 0.5, 0.7]
    let liquorSizeOz: [Double] = [1, 1.5, 2, 2.5, 12, 25, 40]
    let liquorVolume: [Double] = [20, 35, 37, 40, 50, 55, 60, 65, 70, 75, 80]
    
    
    
}


