//
//  ShoppingViewController.swift
//  kanriseyo
//
//  Created by mac on 2020/11/03.
//  Copyright © 2020 03pink12. All rights reserved.
//

import UIKit
import RealmSwift

class ShoppingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var items: Items!
    var updataArray = [Int:Int]()
    var stockTF = Int()
    
    // Realmインスタンスを取得する
    let realm = try! Realm()
    var itemsArray = try! Realm().objects(Items.self).filter("notice_date <= %@ || out_date <= %@",Date(),Date()).sorted(byKeyPath: "created_at", ascending: false)
    
    override func viewWillAppear(_ animated: Bool) {
        itemsArray = try! Realm().objects(Items.self).filter("notice_date <= %@ || out_date <= %@",Date(),Date()).sorted(byKeyPath: "created_at", ascending: false)
        self.tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        // カスタムセルを登録する
        let nib = UINib(nibName: "ShoppingTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ShoppingCell")
        
        //アイテムの合計金額を表示
        var total = 0
        for priceData in itemsArray{
            total += priceData.price
        }
        self.totalLabel.text = "合計金額：¥\(total)"

        navigationBar.delegate = self
    }
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得してデータを設定する
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCell", for: indexPath) as! ShoppingTableViewCell
        cell.setItemsData(itemsArray[indexPath.row])
        // セル内のボタンのアクションをソースコードで設定する
        cell.checkButton.addTarget(self, action:#selector(handleButton(_:forEvent:)), for: .touchUpInside)
        return cell
    }
    // 各セルを選択した時に実行されるメソッド
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }*/
    
    @objc func handleButton(_ sender: UIButton, forEvent event: UIEvent) {
        print("DEBUG_PRINT: checkボタンがタップされました。")
        // タップされたセルのインデックスを求める
        let touch = event.allTouches?.first
        let point = touch!.location(in: self.tableView)
        let indexPath = tableView.indexPathForRow(at: point)
        let cell = tableView.cellForRow(at: indexPath!) as! ShoppingTableViewCell

        // 配列からタップされたインデックスのデータを取り出す
        let itemsData = itemsArray[indexPath!.row]
        let id = itemsData.id
        var buttonImage = UIImage(named: "check_circle_off")
        if updataArray[id] != nil {
            updataArray[id] = nil
            buttonImage = UIImage(named: "check_circle_off")
            cell.stockTextField.isUserInteractionEnabled = true
        }else{
            stockTF = Int(cell.stockTextField.text ?? "1") ?? 1
            updataArray[id] = stockTF
            buttonImage = UIImage(named: "check_circle_on")
            cell.stockTextField.isUserInteractionEnabled = false
        }
        cell.checkButton.setImage(buttonImage, for: .normal)
        print(updataArray)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        for (id , number) in updataArray{
            try! realm.write {
                let results = realm.objects(Items.self)
                let item = results[id]
                let dateResult = item.stock * item.duration
                item.stock = item.stock + number
                item.notice_date = Calendar.current.date(byAdding: .day, value: (dateResult), to: item.notice_date)!
                item.out_date = Calendar.current.date(byAdding: .day, value: (dateResult), to: item.out_date)!
                setNotificationOutDate(items: item)
                setNotificationNoticsDate(items: item)
            }
        }
        updataArray.removeAll()

        super.viewWillDisappear(animated)
    }
    
    //ローカル通知(在庫切れ)
    func setNotificationOutDate(items: Items) {
        let content = UNMutableNotificationContent()
        // ローカル通知が発動するtrigger（日付マッチ）を作成
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: items.out_date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        // identifier, content, triggerからローカル通知を作成（identifierが同じだとローカル通知を上書き保存）
        let request = UNNotificationRequest(identifier: "\(items.id)_out_date", content: content, trigger: trigger)

        // ローカル通知を登録
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            print(error ?? "在庫切れローカル通知登録 OK")  // error が nil ならローカル通知の登録に成功したと表示します。errorが存在すればerrorを表示します。
        }
        
    }
    //ローカル通知(在庫のりこわずか)
    func setNotificationNoticsDate(items: Items) {
        let content = UNMutableNotificationContent()
        // タイトルと内容を設定(中身がない場合メッセージ無しで音だけの通知になるので「(xxなし)」を表示する)
        if items.name == "" {
            content.title = "(商品名なし)"
        } else {
            content.title = items.name
        }
        content.body = "在庫が少なくなくなりました"
        content.sound = UNNotificationSound.default

        // ローカル通知が発動するtrigger（日付マッチ）を作成
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: items.notice_date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        // identifier, content, triggerからローカル通知を作成（identifierが同じだとローカル通知を上書き保存）
        let request = UNNotificationRequest(identifier: "\(items.id)_notice_date", content: content, trigger: trigger)

        // ローカル通知を登録
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            print(error ?? "残りわずかローカル通知登録 OK")  // error が nil ならローカル通知の登録に成功したと表示します。errorが存在すればerrorを表示します。
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
