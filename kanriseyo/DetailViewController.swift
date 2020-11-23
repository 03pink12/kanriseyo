//
//  DetailViewController.swift
//  kanriseyo
//
//  Created by mac on 2020/11/22.
//  Copyright © 2020 03pink12. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var memoLabel: UILabel!
    
    var items: Items!
    
    //延長ボタン
    @IBAction func extendBtn(_ sender: Any) {
    }
    //編集ボタン
    @IBAction func updataBtn(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let duration = items.duration * items.stock
        let elapsedDays = Calendar.current.dateComponents([.day], from: items.updated_at, to: Date()).day
        let countdown = duration - elapsedDays!
        stockLabel.text = "\(items.stock)"
        countdownLabel.text = "\(countdown)"
        memoLabel.text = items.memo
        pictureImageView.image = UIImage(data: items.image_file)
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let createViewController:CreateViewController = segue.destination as! CreateViewController

        if segue.identifier == "updateSegue" {
            createViewController.items = items
            createViewController.noticeStock = items.notice_stock
            createViewController.noticeDay = items.notice_day
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
