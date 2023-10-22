//
//  FoodCollectionViewCell.swift
//  Yemek'De
//
//  Created by Duygu Yesiloglu on 11.10.2023.
//

import UIKit
import SwiftUI


    class FoodCollectionViewCell: UICollectionViewCell {
        @IBOutlet weak var foodImage: UIImageView!
        @IBOutlet weak var foodPrice: UILabel!
        @IBOutlet weak var foodName: UILabel!

        override func awakeFromNib() {
            super.awakeFromNib()
            self.layer.cornerRadius = 20
            self.layer.masksToBounds = true
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.white.cgColor
        }
    }


 
