//
//  Protocols.swift
//  Yemek'De
//
//  Created by Duygu Yesiloglu on 10.10.2023.
//

import Foundation

protocol DetailPageToHomePage {
    func sendBadgeCountToHomePage(badgeCount: Int)
}

protocol OrderDetailToCartPage {
    func deleteCart()
}

protocol CartPlusOrMinus {
    func cartPlus(indexPath: IndexPath)
    func cartMinus(indexPath: IndexPath)
}
