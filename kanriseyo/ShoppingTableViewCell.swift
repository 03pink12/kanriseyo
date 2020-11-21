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
    
    let checkImageName = ["check_circle_off", "check_circle_on"]
    var checkImgNo = 0
    
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
    }
    @IBAction func checkTap(_ sender: Any) {
        // ボタンを更新する
        if checkImgNo == 0 {
            checkImgNo = 1
        } else if checkImgNo == 1 {
            checkImgNo = 0
        }
        let buttonImage = UIImage(named: checkImageName[checkImgNo])
        self.checkButton.setImage(buttonImage, for: .normal)
    }
    
}
    

