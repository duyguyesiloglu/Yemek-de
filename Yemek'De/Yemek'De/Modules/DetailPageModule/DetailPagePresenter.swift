//
//  DetailPagePresenter.swift
//  Yemek'De
//
//  Created by Duygu Yesiloglu on 11.10.2023.
//

import Foundation

class DetailPagePresenter: ViewToPresenterDetailPageProtocol, InteractorToPresenterDetailPageProtocol {
    var detailPageInteractor: PresenterToInteractorDetailPageProtocol?
    var detailPageView: PresenterToViewDetailPageProtocol?

    func getCartInfo() {
        detailPageInteractor?.getCartInfoI()
    }

    func deleteFromCart(sepet_yemek_id: String, kullanici_adi: String) {
        detailPageInteractor?.deleteFromCartI(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }

    func minus() {
        detailPageInteractor?.minusI()
    }

    func plus() {
        detailPageInteractor?.plusI()
    }

    func setTotalPrice(price: Int) {
        detailPageInteractor?.hesap(price: price)
    }

    func addToCart(food: Foods, unit: String) {
        detailPageInteractor?.addToCartI(food: food, unit: unit)
    }

    func cartInfoToPresenter(cartFood: [FoodsCart]) {
        detailPageView?.cartInfoToView(cartFood: cartFood)
    }

    func unitDataToPresenter(number: Int) {
        detailPageView?.unitDataToView(number: number)
    }

    func totalPriceDataToPresenter(number: Int) {
        detailPageView?.totalPriceDataToView(number: number)
    }
}
