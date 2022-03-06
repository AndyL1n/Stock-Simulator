//
//  StockItem.swift
//  StockMain
//
//  Created by Andy on 2022/3/6.
//

import Foundation

public struct StockItem {
    let code: String
    let name: String
    let tradeVol: String
    let turnover: String
    let openingPrice: String
    let ceilingPrice: String
    let floorPrice: String
    let closingPrice: String
    let speard: String
    let totalVol: String
}

extension StockItem: Codable {
    enum CodingKeys: String, CodingKey {
        case code           = "證券代號"
        case name           = "證券名稱"
        case tradeVol       = "成交股數"
        case turnover       = "成交金額"
        case openingPrice   = "開盤價"
        case ceilingPrice   = "最高價"
        case floorPrice     = "最低價"
        case closingPrice   = "收盤價"
        case speard         = "漲跌價差"
        case totalVol       = "成交筆數"
    }
}
