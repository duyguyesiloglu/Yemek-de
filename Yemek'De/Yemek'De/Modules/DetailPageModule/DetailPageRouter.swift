//
//  DetailPageRouter.swift
//  Yemek'De
//
//  Created by Duygu Yesiloglu on 11.10.2023.
//

import Foundation

class DetailPageRouter{
    static func createModule(ref: DetailPageViewController){
        let presenter = DetailPagePresenter()
        ref.detailPagePresenterObject = presenter
        ref.detailPagePresenterObject?.detailPageInteractor = DetailPageInteractor()
        ref.detailPagePresenterObject?.detailPageInteractor?.detailPagePresenter = presenter
        ref.detailPagePresenterObject?.detailPageView = ref
    }
}
