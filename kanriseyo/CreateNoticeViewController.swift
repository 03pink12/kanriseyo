//
//  CreateNoticeViewController.swift
//  kanriseyo
//
//  Created by mac on 2020/11/15.
//  Copyright © 2020 03pink12. All rights reserved.
//

import UIKit
import FloatingPanel

class CreateNoticeViewController: UIViewController,FloatingPanelControllerDelegate {

    @IBOutlet weak var noticeStockTextField: UITextField!
    @IBOutlet weak var noticeDayTextField: UITextField!
    @IBOutlet weak var navigationView: UIView!
    
    var createVC : CreateViewController!
    var noticeStock = Int()
    var noticeDay = Int()
    
    override func viewDidLayoutSubviews() {
        self.navigationView.addBorder(width: 0.5, color: UIColor(hex: "BDBDBF"), position: .bottom)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noticeStockTextField.text = String(noticeStock)
        noticeDayTextField.text = String(noticeDay)
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        noticeStockTextField.text = String(noticeStock)
        noticeDayTextField.text = String(noticeDay)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        noticeStock = Int(noticeStockTextField.text ?? "0") ?? 0
        noticeDay = Int(noticeDayTextField.text ?? "0") ?? 0
        // 前画面のViewControllerを取得
        createVC.noticeStock = self.noticeStock
        createVC.noticeDay = self.noticeDay
        createVC.noticeSettingLabel.text = "在庫数が\(createVC.noticeStock)になる\(createVC.noticeDay)日前に通知する"
        dismiss(animated: true, completion: nil)
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
