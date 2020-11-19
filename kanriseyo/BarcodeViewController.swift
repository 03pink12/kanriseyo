//
//  BarcodeViewController.swift
//  kanriseyo
//
//  Created by mac on 2020/11/14.
//  Copyright © 2020 03pink12. All rights reserved.
//

import UIKit
import RealmSwift
class BarcodeViewController: UIViewController {
    
    let realm = try! Realm()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let createViewController:CreateViewController = segue.destination as! CreateViewController
        if segue.identifier == "manual_input" {
            let items = Items()
            let allItems = realm.objects(Items.self)
            if allItems.count != 0 {
                items.id = allItems.max(ofProperty: "id")! + 1
            }
            createViewController.items = items
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
