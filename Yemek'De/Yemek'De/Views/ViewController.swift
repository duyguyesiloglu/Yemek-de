//
//  ViewController.swift
//  Yemek'De
//
//  Created by Duygu Yesiloglu on 11.10.2023.
//

import UIKit
import Kingfisher
import Alamofire

class ViewController: UIViewController {
    var homePagePresenterObject: ViewToPresenterHomePageProtocol?
    
    var allFoods = [Foods]()
    var badgeForCart = 0

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var foodCollectionView: UICollectionView!
    var cellWidth: CGFloat = 0
    var cellHeight: CGFloat = 0
    var spacing: CGFloat = 5
    var numberOfColumn: CGFloat = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tabBar = tabBarController?.tabBar {
            tabBar.barTintColor = .white // Set the background color to white
            tabBar.tintColor = UIColor(named: "wp") // Set the selected item color to white
        }
        setup()
        HomePageRouter.createModule(ref: self)
        indicator.hidesWhenStopped = true
          indicator.startAnimating()
        homePagePresenterObject?.getAllFoods()
        }
    }

extension ViewController {
    func setup () {
        foodCollectionView.dataSource = self
        foodCollectionView.delegate = self
        searchBar.delegate = self
    }
}

extension ViewController: PresenterToViewHomePageProtocol {
    func sendDataToView(foods: [Foods]) {
        self.allFoods = foods
        DispatchQueue.main.async {
            self.foodCollectionView.reloadData()
            self.indicator.stopAnimating()
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allFoods.count
    }
    
//Kingfisher
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as! FoodCollectionViewCell

        let url = "http://kasimadalan.pe.hu/yemekler/resimler/"
        let tempFood = allFoods[indexPath.row]

        if let url = URL(string: "\(url)\(tempFood.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                cell.foodImage.kf.setImage(with: url)
            }

        }
        cell.foodName.text = tempFood.yemek_adi
        cell.foodPrice.text = "\(tempFood.yemek_fiyat!)₺"

        return cell
    }
    
// Sayfa Gecisi
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let food = allFoods[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: food)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
// Sayfa gecisi Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let food = sender as? Foods {
                let gidilecekVC = segue.destination as! DetailPageViewController
                gidilecekVC.food = food
            }
        }
    }
}

// Search Bar
extension ViewController: UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            homePagePresenterObject?.getAllFoods()
        } else {
            homePagePresenterObject?.ara(searchText: searchText)
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.bounds.width - (spacing * (numberOfColumn + 1))
        let cellWidth = availableWidth / numberOfColumn
        return CGSize(width: cellWidth, height: cellWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
    }
     }

