//
//  DetailPageViewController.swift
//  Yemek'De
//
//  Created by Duygu Yesiloglu on 11.10.2023.
//

import UIKit
import Kingfisher


class DetailPageViewController: UIViewController {

    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var foodCountLabel: UILabel!

    var cartFoods: [FoodsCart] = []
    var food: Foods?
    var detailPagePresenterObject: ViewToPresenterDetailPageProtocol?
    var delegate: DetailPageToHomePage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DetailPageRouter.createModule(ref: self)
        
        // Direkt resim adıyla çeken kod
        let url = "http://kasimadalan.pe.hu/yemekler/resimler/"
        if let f = food {
            if let url = URL(string: "\(url)\(f.yemek_resim_adi!)") {
                DispatchQueue.main.async {
                    self.foodImageView.kf.setImage(with: url)
                }
            }

            foodPriceLabel.text = "\(f.yemek_fiyat!)₺"
        
            foodNameLabel.text = f.yemek_adi
            let totalPrice = f.yemek_fiyat!
            let totalPriceString = String(format: NSLocalizedString("Price", comment: ""), totalPrice)
            totalPriceLabel.text = totalPriceString.localized()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        detailPagePresenterObject?.getCartInfo()
    }
    var badgeForCart = 0
    
// Bildirim
    
    @IBAction func addToCartButton(_ sender: Any) {
        let bildirim = UIAlertController(title: "Done!", message: NSLocalizedString("Added to cart.", comment: ""), preferredStyle: .alert)
        self.present(bildirim, animated: true)
        let okeyAction = UIAlertAction(title: "Cancel".localized(), style: .cancel) {
            action in
            self.navigationController?.popViewController(animated: true)
        }

        bildirim.addAction(okeyAction)
        var toplamUnitString = foodCountLabel.text!
        
        if let existCart = cartFoods.first(where: { $0.yemek_adi! == food?.yemek_adi! }) {
            self.detailPagePresenterObject?.deleteFromCart(sepet_yemek_id: existCart.sepet_yemek_id!, kullanici_adi: "dYesiloglu")
            let toplamUnit = Int(existCart.yemek_siparis_adet!)! + Int(foodCountLabel.text!)!
            toplamUnitString = String(toplamUnit)
            badgeForCart = cartFoods.count
        } else {
            badgeForCart = cartFoods.count + 1
        }
        delegate?.sendBadgeCountToHomePage(badgeCount: badgeForCart)
        detailPagePresenterObject?.addToCart(food: food!, unit: toplamUnitString)
    }

    
    @IBAction func buttonMinus(_ sender: Any) {
        if let a = foodCountLabel.text {
            if let a = Int(a) {
                if a > 1 {
                    detailPagePresenterObject?.minus()
                    if let price = food?.yemek_fiyat {
                        detailPagePresenterObject?.setTotalPrice(price: Int(price)!)
                    }
                }
            }
        }
    }

    @IBAction func buttonPlus(_ sender: Any) {
        if let a = foodCountLabel.text {
            if let a = Int(a) {
                if a < 10 {
                    detailPagePresenterObject?.plus()
                    if let price = food?.yemek_fiyat {
                        detailPagePresenterObject?.setTotalPrice(price: Int(price)!)
                    }
                }
            }
        }
    }
}


extension DetailPageViewController: PresenterToViewDetailPageProtocol {

    func cartInfoToView(cartFood: [FoodsCart]) {
        self.cartFoods = cartFood
    }

    func unitDataToView(number: Int) {
        foodCountLabel.text = String(number)
    }

    func totalPriceDataToView(number: Int) {
        totalPriceLabel.text = "Total: \(String(number))₺"
    }
}
