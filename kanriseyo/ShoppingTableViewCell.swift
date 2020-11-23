//
//  ShoppingTableViewCell.swift
//  kanriseyo
//
//  Created by mac on 2020/11/05.
//  Copyright © 2020 03pink12. All rights reserved.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var stockTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setItemsData(_ items: Items) {
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
            self.stockTextField.text = "\(items.unit)"
            let buttonImage = UIImage(named: "check_circle_off")
            self.checkButton.setImage(buttonImage, for: .normal)
            self.stockTextField.isUserInteractionEnabled = true
    }
    @IBAction func checkTap(_ sender: Any) {

    }
    
}
    

