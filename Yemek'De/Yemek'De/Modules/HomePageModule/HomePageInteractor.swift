//
//  HomePageInteractor.swift
//  Yemek'De
//
//  Created by Duygu Yesiloglu on 11.10.2023.
//

import Foundation
import Alamofire
class HomePageInteractor: PresenterToInteractorHomePageProtocol {
    var homePagePresenter: InteractorToPresenterHomePageProtocol?
    var allFoods = [Foods]()

    // Search Foods
    
    func arama(searchText: String) {
        let lowercaseSearchText = searchText.lowercased()
        let matchingFoods = allFoods.filter { food in
            if let yemekAdi = food.yemek_adi?.lowercased() {
                return yemekAdi.contains(lowercaseSearchText)
            }
            return false
        }
        homePagePresenter?.sendDataToPresenter(foods: matchingFoods)
    }


    func getAllFoodsInteractor() {
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response { response in
            if let data = response.data {
                do {
                    let answer = try JSONDecoder().decode(FoodsResponse.self, from: data)
                    if let foods = answer.yemekler {
                        self.allFoods = foods
                        self.homePagePresenter?.sendDataToPresenter(foods: foods)
                    }
                } catch {
                    print(error.localizedDescription.description)
                }
            }
        }
    }
    

}
