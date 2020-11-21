//
//  Groups.swift
//  kanriseyo
//
//  Created by mac on 2020/11/14.
//  Copyright © 2020 03pink12. All rights reserved.
//

import RealmSwift

class Groups: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""

    // id をプライマリーキーとして設定
    override static func primaryKey() -> String? {
        return "id"
    }
}
