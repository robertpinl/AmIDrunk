//
//  DrinkSelectionViewController.swift
//  AmIDrunk
//
//  Created by Robert Pinl on 14.02.2021.
//

import UIKit

class DrinkSelectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let data = DataSet()
    var volume = [Double]()
    var size = [Double]()
    
    var ozConstant = Double()
    var sizeLabel = String()
    var unit = String()
    
    var selectedVolume: Double = 0
    var selectedSize: Double = 0
    
    var drink: DrinkModel!
    var drinkArray = [DrinkModel]()
    
    var sexConstant = Double()
    var weightConstant = Double()
    var weight = Double()
    var lastDrink = Date()
    
    var alc: Double = 0.0
    var estimateHours = Double()
    var resultPromile = Double()
    
    var imperialUnits = Bool() {
        didSet {
            if imperialUnits == true {
                ozConstant = 35.1950652
                sizeLabel = "oz"
            } else if imperialUnits == false {
                ozConstant = 1
                sizeLabel = "l"
            }
        }
    }
    
    var selectedDrink: String = "Beer" {
        didSet {
            if imperialUnits == false {
                switch selectedDrink {
                case "Beer":
                    volume = data.beerVolume
                    size = data.beerSize
                case "Vine":
                    volume = data.wineVolume
                    size = data.wineSize
                case "Cider":
                    volume = data.ciderVolume
                    size = data.ciderSize
                case "Liquor":
                    volume = data.liquorVolume
                    size = data.liquorSize
                default:
                    volume = []
                    size = []
                }
            } else {
                switch selectedDrink {
                case "Beer":
                    volume = data.beerVolume
                    size = data.beerSizeOz
                case "Vine":
                    volume = data.wineVolume
                    size = data.wineSizeOz
                case "Cider":
                    volume = data.ciderVolume
                    size = data.ciderSizeOz
                case "Liquor":
                    volume = data.liquorVolume
                    size = data.liquorSizeOz
                default:
                    volume = []
                    size = []
                }
            }
            clearSelected()
            sizeCollectionView.reloadData()
            volumeCollectionView.reloadData()
        }
    }
    
    let formatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.maximumFractionDigits = 2
        nf.minimumFractionDigits = 0
        return nf
    }()
    
    @IBOutlet weak var drinkCollectionView: UICollectionView!
    @IBOutlet weak var volumeCollectionView: UICollectionView!
    @IBOutlet weak var sizeCollectionView: UICollectionView!
    @IBOutlet weak var selectedCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    
    //MARK: - CollectionView delegate and datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.drinkCollectionView {
            return data.categories.count
        } else if collectionView == self.volumeCollectionView {
            return volume.count
        } else if collectionView == self.sizeCollectionView{
            return size.count
        } else {
            return drinkArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.drinkCollectionView {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: K.drinkCell, for: indexPath) as! DrinkCollectionViewCell
            let drink = data.categories[indexPath.item]
            cellA.drinkLabel.text = drink.title
            cellA.drinkImage.image = UIImage(named: drink.imageName)
            return cellA
        } else if collectionView == self.volumeCollectionView {
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: K.volumeCell, for: indexPath) as! VolumeCollectionViewCell
            cellB.volumeLabel.text = "\(Int(volume[indexPath.item]))%"
            return cellB
        } else if collectionView == self.sizeCollectionView {
            let cellC = collectionView.dequeueReusableCell(withReuseIdentifier: K.sizeCell, for: indexPath) as! SizeCollectionViewCell
            cellC.sizeLabel.text = "\(formatter.string(from: NSNumber(value: size[indexPath.item]))!)\(sizeLabel)"
            return cellC
        } else {
            let cellD = collectionView.dequeueReusableCell(withReuseIdentifier: K.selectedCell, for: indexPath) as! SelectedCollectionViewCell
            let drink = drinkArray[indexPath.item]
            cellD.selectedDrinkLabel.text = drink.category
            cellD.selectedSizeLabel.text = "\(formatter.string(from: NSNumber(value: drink.size))!)\(sizeLabel)"
            cellD.selectedVolumeLabel.text = "\(Int(drink.volume))%"
            return cellD
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == drinkCollectionView {
            return CGSize(width: 115, height: 115)
        } else if collectionView == selectedCollectionView {
            return CGSize(width: 68, height: 68)
        } else {
            return CGSize(width: 62, height: 30)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cellA = collectionView.cellForItem(at: indexPath) as? DrinkCollectionViewCell {
            cellA.view.backgroundColor = .selectedButtonBackground
            cellA.view.layer.borderWidth = 2
            cellA.view.layer.borderColor = UIColor.darkBlue.cgColor
            cellA.drinkLabel.textColor = .fontColor
            cellA.drinkImage.image = UIImage(named: data.categories[indexPath.item].selectedImage)
            selectedDrink = data.categories[indexPath.item].title
        }
        if let cellB = collectionView.cellForItem(at: indexPath) as? SizeCollectionViewCell {
            cellB.view.backgroundColor = .selectedButtonBackground
            cellB.view.layer.borderWidth = 2
            cellB.view.layer.borderColor = UIColor.darkBlue.cgColor
            cellB.sizeLabel.textColor = .fontColor
            selectedSize = size[indexPath.item]
        }
        if let cellC = collectionView.cellForItem(at: indexPath) as? VolumeCollectionViewCell {
            cellC.view.backgroundColor = .selectedButtonBackground
            cellC.view.layer.borderWidth = 2
            cellC.view.layer.borderColor = UIColor.darkBlue.cgColor
            cellC.volumeLabel.textColor = .fontColor
            selectedVolume = volume[indexPath.item]
        }
        if let _ = collectionView.cellForItem(at: indexPath) as? SelectedCollectionViewCell {
            alc -= drinkArray[indexPath.item].alc
            drinkArray.remove(at: indexPath.item)
            selectedCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cellA = collectionView.cellForItem(at: indexPath) as? DrinkCollectionViewCell {
            cellA.view.backgroundColor = .darkBlue
            cellA.drinkLabel.textColor = .whiteFontColor
            cellA.view.layer.borderWidth = 0
            cellA.drinkImage.image = UIImage(named: data.categories[indexPath.item].imageName)
        }
        if let cellB = collectionView.cellForItem(at: indexPath) as? SizeCollectionViewCell {
            cellB.view.backgroundColor = .darkBlue
            cellB.view.layer.borderWidth = 0
            cellB.sizeLabel.textColor = .whiteFontColor
        }
        if let cellC = collectionView.cellForItem(at: indexPath) as? VolumeCollectionViewCell {
            cellC.view.backgroundColor = .darkBlue
            cellC.view.layer.borderWidth = 0
            cellC.volumeLabel.textColor = .whiteFontColor
        }
    }
    
    
    //MARK: - IBActions
    
    @IBAction func AddButtonPressed(_ sender: UIButton) {
        //Add drinks to array
        if selectedSize != 0, selectedVolume != 0 {
            let alcInGrams = (selectedSize * 1000 / ozConstant) * (selectedVolume / 100)
            drinkArray.append(DrinkModel(category: selectedDrink, volume: selectedVolume, size: selectedSize, alc: alcInGrams))
            selectedCollectionView.reloadData()
            alc += alcInGrams
            print(alcInGrams)
            clearSelected()
            selectedSize = 0
            selectedVolume = 0
            sizeCollectionView.scrollToItem(at: [0], at: .left, animated: true)
            volumeCollectionView.scrollToItem(at: [0], at: .left, animated: true)
        }
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        let calculatedWeight = weight * 1000.0 * sexConstant // weight in grams * sex constant (male 0.68, female 0.55)
        resultPromile = alc / calculatedWeight * 100 * 10 / 1.8 // alc in grams / weight const / 100 / 10(% -> promile)
        estimateHours = alc / (weight/weightConstant) // burn constant kg -> male = 10kg / female 8,5kg
        performSegue(withIdentifier: K.Segue.results, sender: self)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segue.results {
            if let resultsVC = segue.destination as? ResultsViewController {
                resultsVC.promile = resultPromile
                resultsVC.time = lastDrink.addingTimeInterval(estimateHours * 60 * 60 / 1.7)
                resultsVC.estimateTime = estimateHours * 60 * 60 / 1.7
            }
        }
    }
    
    
    //MARK: - Functions
    
    func setUI() {
        drinkCollectionView.backgroundColor = .none
        volumeCollectionView.backgroundColor = .none
        sizeCollectionView.backgroundColor = .none
        selectedCollectionView.backgroundColor = .none
    }
    
    func clearSelected() {
        
        if size.count > 0 {
            for item in 0...size.count - 1 {
                let indexP = NSIndexPath(item: item, section: 0)
                sizeCollectionView.deselectItem(at: indexP as IndexPath, animated: true)
                let cell = sizeCollectionView.cellForItem(at: indexP as IndexPath) as? SizeCollectionViewCell
                cell?.view.backgroundColor = .darkBlue
                cell?.view.layer.borderWidth = 0
                cell?.sizeLabel.textColor = .whiteFontColor
            }
            
            for item in 0...volume.count - 1 {
                let indexP = NSIndexPath(item: item, section: 0)
                volumeCollectionView.deselectItem(at: indexP as IndexPath, animated: true)
                let cell = volumeCollectionView.cellForItem(at: indexP as IndexPath) as? VolumeCollectionViewCell
                cell?.view.backgroundColor = .darkBlue
                cell?.view.layer.borderWidth = 0
                cell?.volumeLabel.textColor = .whiteFontColor
            }
        }
    }
}
