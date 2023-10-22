//
//  CartPageRouter.swift
//  Yemek'De
//
//  Created by Duygu Yesiloglu on 11.10.2023.
//

import Foundation

class CartPageRouter: PresenterToRouterCartPageProtocol {
    static func createModule(ref: CartPageViewController) {
        let presenter = CartPagePresenter()
        ref.cartPagePresenterObject = presenter
        ref.cartPagePresenterObject?.cartPageInteractor = CartPageInteractor()
        ref.cartPagePresenterObject?.cartPageView = ref
        ref.cartPagePresenterObject?.cartPageInteractor?.cartPagePresenter = presenter
    }
}
