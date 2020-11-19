//
//  Histories.swift
//  kanriseyo
//
//  Created by mac on 2020/11/14.
//  Copyright © 2020 03pink12. All rights reserved.
//

import RealmSwift

class Histories: Object {
    @objc dynamic var id = 0
    @objc dynamic var item_id = 0
    @objc dynamic var number = 0
    @objc dynamic var date = Date()

    // id をプライマリーキーとして設定
    override static func primaryKey() -> String? {
        return "id"
    }
}
