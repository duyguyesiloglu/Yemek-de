//
//  DetailPageInteractor.swift
//  Yemek'De
//
//  Created by Duygu Yesiloglu on 11.10.2023.
//

import Foundation
import Alamofire

class DetailPageInteractor: PresenterToInteractorDetailPageProtocol {
    var detailPagePresenter: InteractorToPresenterDetailPageProtocol?
    var unit = 1

    func getCartInfoI() {
        let veri: Parameters = ["kullanici_adi": "dYesiloglu"]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: veri).response { response in
            if let data = response.data {
                do {
                    let answer = try JSONDecoder().decode(FoodsCartResponse.self, from: data)
                    if let answerArray = answer.sepet_yemekler {
                        self.detailPagePresenter?.cartInfoToPresenter(cartFood: answerArray)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

    func deleteFromCartI(sepet_yemek_id: String, kullanici_adi: String) {
        let param: Parameters = ["sepet_yemek_id": sepet_yemek_id, "kullanici_adi": "dYesiloglu"]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: param).response { response in
            if let data = response.data {
                do {
                    let answer = try JSONSerialization.jsonObject(with: data)
                    print(answer)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

    func addToCartI(food: Foods, unit: String) {
        if let yemek_adi = food.yemek_adi, let yemek_resim_adi = food.yemek_resim_adi, let yemek_fiyat = food.yemek_fiyat {
            if let intUnit = Int(unit), let intFiyat = Int(yemek_fiyat) {
                let params: Parameters = ["yemek_adi": yemek_adi, "yemek_resim_adi": yemek_resim_adi, "yemek_fiyat": intFiyat, "yemek_siparis_adet": intUnit, "kullanici_adi": "dYesiloglu"]
                AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php", method: .post, parameters: params).response { response in
                    if let data = response.data {
                        do {
                            let cevap = try JSONSerialization.jsonObject(with: data)
                            print(cevap)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }




    func minusI() {
        unit -= 1
        detailPagePresenter?.unitDataToPresenter(number: unit)
    }

    func plusI() {
        unit += 1
        detailPagePresenter?.unitDataToPresenter(number: unit)
    }

    func hesap(price: Int) {
        let totalPrice = price * unit
        detailPagePresenter?.totalPriceDataToPresenter(number: totalPrice)

    }

}
