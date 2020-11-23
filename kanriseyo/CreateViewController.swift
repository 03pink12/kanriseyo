//
//  CreateViewController.swift
//  kanriseyo
//
//  Created by mac on 2020/11/03.
//  Copyright © 2020 03pink12. All rights reserved.
//

import UIKit
import RealmSwift
import FloatingPanel

class CreateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,FloatingPanelControllerDelegate {
    let realm = try! Realm()
    var items: Items!
    var floatingPanelController: FloatingPanelController!

    //半モーダル
    var fpc = FloatingPanelController()
    
    //@IBOutlet weak var saveButtonLabel: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var stockTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var unitTextField: UITextField!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var noticeSettingLabel: UILabel!
    
    var noticeStock = Int()
    var noticeDay = Int(10)
    
    //表示
    override func viewDidLoad() {
        super.viewDidLoad()
       // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
       let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
       self.view.addGestureRecognizer(tapGesture)
        
        //半モーダルを用意
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createNoticeVC = storyboard.instantiateViewController(withIdentifier: "CreateNotice") as! CreateNoticeViewController
        fpc.delegate = self
        let appearance = SurfaceAppearance()
        appearance.cornerRadius = 10.0
        fpc.surfaceView.appearance = appearance
        createNoticeVC.noticeStock = noticeStock
        createNoticeVC.noticeDay = noticeDay
        fpc.set(contentViewController: createNoticeVC)
        
        //文字列をセット
        nameTextField.text = items.name
        priceTextField.text = String(items.price)
        let image:UIImage? = UIImage(data: items.image_file)
        if image != nil {
            pictureImageView.image = UIImage(data: items.image_file)
        } else {
            pictureImageView.image = UIImage(named:"no_image.png")
        }
        stockTextField.text = String(items.stock)
        durationTextField.text = String(items.duration)
        memoTextView.text = items.memo
        unitTextField.text = String(items.unit)
        noticeSettingLabel.text = "在庫数が\(noticeStock)になる\(noticeDay)日前に通知する"
    }

    /*func floatingPanelWillRemove(_ fpc: FloatingPanelController) {
        print("おかわり")
        print(noticeDay)
        noticeSettingLabel.text = "在庫数が\(noticeStock)になる\(noticeDay)日前に通知する"
    }*/
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 半モーダルビューを非表示にする
        fpc.removePanelFromParent(animated: true)
    }
    
    //「保存」タップ
    @IBAction func saveButton(_ sender: Any) { //登録か編集かで分ける
        let stock = Int(self.stockTextField.text ?? "0") ?? 0
        let duration = Int(self.durationTextField.text ?? "0") ?? 0
        //お知らせする日にちの計算 = 今日 + ((在庫数-通知在庫)*使用期間) - 通知日数
        let noticeDateResult = ((stock - noticeStock) * duration) - noticeDay
        let noticeDate = Calendar.current.date(byAdding: .day, value: (noticeDateResult), to: Date())!
        //なくなる日 = 今日 + (在庫数 * 使用期間)
        let outDateResult = stock * duration
        let outDate = Calendar.current.date(byAdding: .day, value: outDateResult, to: Date())!
        try! realm.write {
            self.items.name = self.nameTextField.text!
            self.items.price = Int(self.priceTextField.text ?? "0") ?? 0
            self.items.stock = stock
            self.items.duration = duration
            self.items.memo = self.memoTextView.text!
            self.items.unit = Int(self.unitTextField.text ?? "0") ?? 0
            self.items.image_file = self.pictureImageView.image?.pngData() ?? Data()
            self.items.jan_code = 0
            self.items.group_id = 0
            self.items.notice_flg = false
            self.items.notice_stock = self.noticeStock
            self.items.notice_day = self.noticeDay
            self.items.notice_date = noticeDate
            self.items.out_date = outDate
            self.items.created_at = Date() //初めての登録時のみ今日の日付
            self.items.updated_at = Date()
            self.realm.add(self.items, update: .modified)
        }
        //通知用
        setNotificationOutDate(items: items)
        setNotificationNoticsDate(items: items)
        
        //ホームに戻る
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //個数マイナスボタン タップ
    @IBAction func minusButton(_ sender: Any) {
        let stock = Int(self.stockTextField.text ?? "0") ?? 0
        if stock > 0{
            self.stockTextField.text = String(stock - 1)
        }
    }
    
    //個数プラスボタン タップ
    @IBAction func plusButton(_ sender: Any) {
        let stock = Int(self.stockTextField.text ?? "0") ?? 0
        self.stockTextField.text = String(stock + 1)
    }
    
    //「通知設定」タップ
    @IBAction func TapNotice(_ sender: Any) {
        //半モーダルを表示
        fpc.addPanel(toParent: self, animated: true)
        fpc.move(to: .half, animated: true)
    }
    
    //「imgae」タップ
    @IBAction func imageTap(_ sender: Any) {
        //アラート生成
        let actionSheet = UIAlertController(title: "写真の追加方法", message: "選択してください", preferredStyle: UIAlertController.Style.alert)
        let action1 = UIAlertAction(title: "カメラで撮影する", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
            print("カメラで撮影するを選択")
            // カメラを指定してピッカーを開く
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let pickerController = UIImagePickerController()
                pickerController.delegate = self
                pickerController.sourceType = .camera
                self.present(pickerController, animated: true, completion: nil)
            }
        })
        let action2 = UIAlertAction(title: "ライブラリから選択する", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
            print("ライブラリを選択")
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let pickerController = UIImagePickerController()
                pickerController.delegate = self
                pickerController.sourceType = .photoLibrary
                self.present(pickerController, animated: true, completion: nil)
            }
        })
        //UIAlertActionのスタイルがCancelなので赤く表示される
        let close = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.destructive, handler: {
            (action: UIAlertAction!) in
            print("閉じる")
        })
        //UIAlertControllerにActionを追加
        actionSheet.addAction(action1)
        actionSheet.addAction(action2)
        actionSheet.addAction(close)
        //実際にAlertを表示する
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    //画像をUIImageに反映
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if info[.originalImage] != nil {
            // 撮影/選択された画像を取得する
            let image = info[.originalImage] as! UIImage
            pictureImageView.image = image
            picker.dismiss(animated: true)
        }
    }
    
    //キャンセルのとき
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // ImageSelectViewController画面を閉じてタブ画面に戻る
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    //ローカル通知(在庫切れ)
    func setNotificationOutDate(items: Items) {
        let content = UNMutableNotificationContent()
        print(items)
        // タイトルと内容を設定(中身がない場合メッセージ無しで音だけの通知になるので「(xxなし)」を表示する)
        if items.name == "" {
            content.title = "(商品名なし)"
        } else {
            content.title = items.name
        }
        content.body = "在庫がなくなりました"
        content.sound = UNNotificationSound.default

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

        // 未通知のローカル通知一覧をログ出力
        center.getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
            for request in requests {
                print("/---------------")
                print(request)
                print("---------------/")
            }
        }
    }
    
    @objc func dismissKeyboard(){
        // キーボードを閉じる
        view.endEditing(true)
    }
    
    class SearchPanelPhoneDelegate: NSObject, FloatingPanelControllerDelegate, UIGestureRecognizerDelegate {
        unowned let owner: CreateViewController

        init(owner: CreateViewController) {
            self.owner = owner
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
