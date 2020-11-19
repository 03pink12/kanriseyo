//
//  HomeTableViewCell.swift
//  kanriseyo
//
//  Created by mac on 2020/11/05.
//  Copyright © 2020 03pink12. All rights reserved.
//

import UIKit
import RealmSwift

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setItemsData(_ items: Items) {
        let image:UIImage? = UIImage(data: items.image_file)
        if image != nil {
            itemImageView.image = UIImage(data: items.image_file)
        } else {
            itemImageView.image = UIImage(named:"no_image.png")
        }
        if items.name == ""{
           self.nameLabel.text = "(商品名なし)"
        }else{
            self.nameLabel.text = "\(items.name)"
        }
        let price = items.price.numberWidthComma()
        self.priceLabel.text = "¥\(price)"
        let duration = items.duration * items.stock
        let elapsedDays = Calendar.current.dateComponents([.day], from: items.updated_at, to: Date()).day
        let countdown = duration - elapsedDays!
        self.countdownLabel.text = "あと\(countdown)日"
        self.stockLabel.text = "あと\(items.stock)個"
    }

}

