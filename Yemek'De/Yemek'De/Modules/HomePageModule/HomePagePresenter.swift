//
//  HomePagePresenter.swift
//  Yemek'De
//
//  Created by Duygu Yesiloglu on 11.10.2023.
//

import Foundation

class HomePagePresenter: ViewToPresenterHomePageProtocol, InteractorToPresenterHomePageProtocol {
    var homePageInteractor: PresenterToInteractorHomePageProtocol?
    var homePageView: PresenterToViewHomePageProtocol?

    func ara(searchText: String) {
        homePageInteractor?.arama(searchText: searchText)
    }

    func getAllFoods() {
        homePageInteractor?.getAllFoodsInteractor()
    }

    func sendDataToPresenter(foods: [Foods]) {
        homePageView?.sendDataToView(foods: foods)
    }
}
