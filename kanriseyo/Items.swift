//
//  Items.swift
//  kanriseyo
//
//  Created by mac on 2020/11/14.
//  Copyright © 2020 03pink12. All rights reserved.
//

import RealmSwift

class Items: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = String()
    @objc dynamic var price = Int()
    @objc dynamic var stock = 1
    @objc dynamic var duration = 10
    @objc dynamic var memo = String()
    @objc dynamic var unit = 1
    @objc dynamic var image_file = Data()
    @objc dynamic var jan_code = Int()
    @objc dynamic var group_id = Int()
    @objc dynamic var notice_flg = true
    @objc dynamic var notice_stock = 0
    @objc dynamic var notice_day = 10
    @objc dynamic var notice_date = Date()
    @objc dynamic var out_date = Date()
    @objc dynamic var created_at = Date()
    @objc dynamic var updated_at = Date()

    // id をプライマリーキーとして設定
    override static func primaryKey() -> String? {
        return "id"
    }
}
