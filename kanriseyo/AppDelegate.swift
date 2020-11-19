//
//  AppDelegate.swift
//  kanriseyo
//
//  Created by mac on 2020/11/03.
//  Copyright © 2020 03pink12. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // ユーザに通知の許可を求める
         /*let center = UNUserNotificationCenter.current()
         center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
             // Enable or disable features based on authorization
         }*/
        //Navigationのスタイル変更
        changeNavigationBarColor()
        return true
    }
    
    func changeNavigationBarColor() {
        // 全てのNavigation Barの色を変更する
        // Navigation Bar の背景色の変更
        UINavigationBar.appearance().barTintColor = UIColor(red: 0/255, green: 196/255, blue: 195/255, alpha: 1.0)
        // Navigation Bar の文字色の変更
        UINavigationBar.appearance().tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        // Navigation Bar のタイトルの文字色の変更
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)]
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    


}

