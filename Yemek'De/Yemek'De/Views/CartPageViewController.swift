//
//  CartPageViewController.swift
//  Yemek'De
//
//  Created by Duygu Yesiloglu on 11.10.2023.
//

import UIKit

class CartPageViewController: UIViewController {
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var buttonDeleteAll: UIBarButtonItem!
    @IBOutlet weak var totalPriceLabel2: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!

    var totalCartPrice = 0
    var cartPagePresenterObject: ViewToPresenterCartPageProtocol?
    var allFoodsCart = [FoodsCart]()

    override func viewDidLoad() {
        super.viewDidLoad()
        CartPageRouter.createModule(ref: self)
        cartTableView.dataSource = self
        cartTableView.delegate = self
        self.cartTableView.estimatedRowHeight = 200
        self.cartTableView.rowHeight = UITableView.automaticDimension
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        cartPagePresenterObject?.getCartFood()
    }


    @IBAction func buttonConfirmCart(_ sender: Any) {
        let lowerBound = 100000
        let upperBound = 10000000

        let randomNumber = Int(arc4random_uniform(UInt32(upperBound - lowerBound + 1))) + lowerBound

        
        if totalCartPrice > 0 {
            let alert = UIAlertController(title: "Order Number: \(randomNumber)".localized(), message: "Your order has been received ".localized(), preferredStyle: .alert)
            let okeyAction = UIAlertAction(title: "OK".localized(), style: .default)
            alert.addAction(okeyAction)
            self.present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Your cart is empty.".localized(), message: "You can add items to your cart.".localized(), preferredStyle: .alert)
            let okeyAction = UIAlertAction(title: "OK".localized(), style: .default)
            alert.addAction(okeyAction)
            self.present(alert, animated: true)
        }
    }
}

extension CartPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allFoodsCart.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell") as! CartPageTableViewCell

        cell.delegate = self
        cell.indexPath = indexPath

        let url = "http://kasimadalan.pe.hu/yemekler/resimler/"
        let tempFood = allFoodsCart[indexPath.row]

        if let url = URL(string: "\(url)\(tempFood.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                cell.foodImageView.kf.setImage(with: url)
            }
        }
        cell.foodNameLabel.text = tempFood.yemek_adi
        if let foodPrice = Int(tempFood.yemek_fiyat!), let foodAdetInt = Int(tempFood.yemek_siparis_adet!) {
            let totalFoodPrice = foodPrice * foodAdetInt
            cell.foodPrice.text = "\(totalFoodPrice)₺"
            cell.unitLabel.text = "\(tempFood.yemek_siparis_adet!)"
        }
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete".localized()) { (contextualAction, view, bool) in

            let food = self.allFoodsCart[indexPath.row]
            let alertTitle = NSLocalizedString("Delete".localized(), comment: "Title for delete alert")
            let confirmationMessage = String(format: NSLocalizedString("Should the %@ be deleted?".localized(), comment: ""), food.yemek_adi!)
            let alert = UIAlertController(title: alertTitle, message: confirmationMessage, preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .cancel)
            alert.addAction(cancelAction)
            let yesAction = UIAlertAction(title: "OK".localized(), style: .destructive) { action in
                self.cartPagePresenterObject?.deleteCartFood(sepet_yemek_id: food.sepet_yemek_id!, kullanici_adi: food.kullanici_adi!)
            }
            alert.addAction(yesAction)
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension CartPageViewController: PresenterToViewCartPageProtocol {
    func sendDataToView(foodsCart: [FoodsCart], totalPrice: Int) {
        indicator.startAnimating()

        self.allFoodsCart = foodsCart
        self.totalCartPrice = totalPrice
        self.totalPriceLabel.text = "\(String(totalPrice))₺"
        self.totalPriceLabel2.text = "\(String(totalPrice))₺"

        DispatchQueue.main.async {
            self.cartTableView.reloadData()
        }

        if allFoodsCart.isEmpty {
            buttonDeleteAll.isEnabled = false
        }
        else {
            buttonDeleteAll.isEnabled = true
        }
        indicator.stopAnimating()

    }
}

extension CartPageViewController: CartPlusOrMinus {

    func cartPlus(indexPath: IndexPath) {
        
        
        let cartFood = allFoodsCart[indexPath.row]
        var unit = cartFood.yemek_siparis_adet
        var unitInt = Int(unit!)!
        
    }

    func cartMinus(indexPath: IndexPath) {
        indicator.startAnimating()

        let cartFood = allFoodsCart[indexPath.row]
        var unit = cartFood.yemek_siparis_adet
        var unitInt = Int(unit!)!
        if unitInt > 1 {
            unitInt -= 1
            unit = String(unitInt)
            cartPagePresenterObject?.changeCartFoodCount(yemek_adi: cartFood.yemek_adi!, yemek_resim_adi: cartFood.yemek_resim_adi!, yemek_fiyat: cartFood.yemek_fiyat!, sepet_yemek_id: cartFood.sepet_yemek_id!, yeniAdet: unit!)
        }
        else {
            print("Error".localized())
            indicator.stopAnimating()
        }
    }
}
