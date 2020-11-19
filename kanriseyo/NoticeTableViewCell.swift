//
//  NoticeTableViewCell.swift
//  kanriseyo
//
//  Created by mac on 2020/11/05.
//  Copyright © 2020 03pink12. All rights reserved.
//

import UIKit

class NoticeTableViewCell: UITableViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var noticeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setItemsData(_ items: Items) {
        let image:UIImage? = UIImage(data: items.image_file)
        if image != nil {
            itemImageView.image = UIImage(data: items.image_file)
        } else {
            itemImageView.image = UIImage(named:"no_image.png")
        }
        var itemName = ""
        if items.name == ""{
           itemName = "(商品名なし)"
        }else{
           itemName = "\(items.name)"
        }
        if items.out_date <= Date(){
            noticeLabel.text = "\(itemName)が\nなくなりました。"
            iconImageView.image = UIImage(named:"notice_danger.png")
        }else if items.notice_date <= Date(){
            noticeLabel.text = "\(itemName)が\nまもなくなくなります。"
            iconImageView.image = UIImage(named:"notice_warning.png")
        }
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
