//
//  CreateNoticeViewController.swift
//  kanriseyo
//
//  Created by mac on 2020/11/15.
//  Copyright © 2020 03pink12. All rights reserved.
//

import UIKit

class CreateNoticeViewController: UIViewController {

    @IBOutlet weak var noticeStockTextField: UITextField!
    @IBOutlet weak var noticeDayTextField: UITextField!
    
    var noticeStock = Int()
    var noticeDay = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = .black
        print("こんにちわ")
        //noticeStockTextField.text = String(noticeStock)
        //noticeDayTextField.text = String(noticeDay)

    }
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        // 前画面のViewControllerを取得
        let createViewController = self.presentingViewController as! CreateViewController
        createViewController.noticeStock = Int(self.noticeStockTextField.text ?? "0") ?? 0
        createViewController.noticeDay = Int(self.noticeStockTextField.text ?? "0") ?? 0
        self.dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let createViewController:CreateViewController = segue.destination as! CreateViewController
        createViewController.noticeStock = Int(self.noticeStockTextField.text ?? "0") ?? 0
        createViewController.noticeDay = Int(self.noticeStockTextField.text ?? "0") ?? 0
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
