//
//  NoticeViewController.swift
//  kanriseyo
//
//  Created by mac on 2020/11/03.
//  Copyright © 2020 03pink12. All rights reserved.
//

import UIKit
import RealmSwift

class NoticeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    
    
    // Realmインスタンスを取得する
    let realm = try! Realm()
    var itemsArray = try! Realm().objects(Items.self).filter("notice_date <= %@ || out_date <= %@",Date(),Date()).sorted(byKeyPath: "created_at", ascending: false)

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        print(itemsArray)
        
        // カスタムセルを登録する
        let nib = UINib(nibName: "NoticeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "NoticeCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         // セルを取得してデータを設定する
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeCell", for: indexPath) as! NoticeTableViewCell
        cell.setItemsData(itemsArray[indexPath.row])
        return cell
    }
    
    // 各セルを選択した時に実行されるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
