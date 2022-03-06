//
//  Date+extension.swift
//  StockMain
//
//  Created by Andy on 2022/3/6.
//

import Foundation

extension Date {
    public var shortString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.calendar = Calendar.current
        formatter.dateFormat = "hh:mm:ss"
        return formatter.string(from: self)
    }
}
