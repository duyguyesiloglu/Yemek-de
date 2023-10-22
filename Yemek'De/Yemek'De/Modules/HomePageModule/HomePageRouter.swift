//
//  HomePageRouter.swift
//  Yemek'De
//
//  Created by Duygu Yesiloglu on 11.10.2023.
//

import Foundation

class HomePageRouter: PresenterToRouterHomePageProtocol {
    static func createModule(ref: ViewController) {
        let presenter = HomePagePresenter()
        ref.homePagePresenterObject = presenter
        ref.homePagePresenterObject?.homePageInteractor = HomePageInteractor()
        ref.homePagePresenterObject?.homePageView = ref
        ref.homePagePresenterObject?.homePageInteractor?.homePagePresenter = presenter
    }
} 
