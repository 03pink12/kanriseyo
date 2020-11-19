//
//  MenuTabBarController.swift
//  kanriseyo
//
//  Created by mac on 2020/11/14.
//  Copyright © 2020 03pink12. All rights reserved.
//

import UIKit

class MenuTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // アイコンの選択時の色
        UITabBar.appearance().tintColor = UIColor(red: 0/255, green: 196/255, blue: 195/255, alpha: 1.0)
        // アイコンの非選択時の色
        UITabBar.appearance().unselectedItemTintColor =  UIColor(red: 189/255, green: 189/255, blue: 191/255, alpha: 1.0)
        // 背景色
        UITabBar.appearance().barTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        

    }
    

}
