//
//  Double+extension.swift
//  StockMain
//
//  Created by Andy on 2022/3/6.
//

import Foundation

extension Double {
    public func decimalString(digit: Int = 0) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = digit
        return formatter.string(from: self as NSNumber)!
    }
    
}
