//
//  Extensions.swift
//  OrderApp
//
//  Created by 김민 on 3/11/24.
//

import Foundation

extension Int {

    func currencyKR() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
