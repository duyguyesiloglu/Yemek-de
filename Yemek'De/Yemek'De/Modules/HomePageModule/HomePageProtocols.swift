//
//  HomePageProtocols.swift
//  Yemek'De
//
//  Created by Duygu Yesiloglu on 11.10.2023.
//

import Foundation

protocol ViewToPresenterHomePageProtocol {
    var homePageInteractor: PresenterToInteractorHomePageProtocol? { get set }
    var homePageView: PresenterToViewHomePageProtocol? { get set }
    func getAllFoods()
    func ara(searchText: String)
}

protocol PresenterToInteractorHomePageProtocol {
    var homePagePresenter: InteractorToPresenterHomePageProtocol? { get set }
    func getAllFoodsInteractor()
    func arama(searchText: String)
}

protocol InteractorToPresenterHomePageProtocol {
    func sendDataToPresenter(foods: [Foods])

}

protocol PresenterToViewHomePageProtocol {
    func sendDataToView(foods: [Foods])
}

protocol PresenterToRouterHomePageProtocol {
    static func createModule(ref: ViewController)
}
