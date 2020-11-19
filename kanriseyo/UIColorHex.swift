//
//  UIColorHex.swift
//  kanriseyo
//
//  Created by mac on 2020/11/19.
//  Copyright © 2020 03pink12. All rights reserved.
//

import UIKit
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let v = Int("000000" + hex, radix: 16) ?? 0
        let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
        let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
        let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
        self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
    }
}
extension Int {
     //数値をカンマ区切り文字列に変換します。
    func numberWidthComma() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        if let result = formatter.string(from: NSNumber(value: self)) {
            return result
        } else {
            return ""
        }
    }
}


