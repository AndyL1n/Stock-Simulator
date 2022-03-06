//
//  StockItem.swift
//  StockMain
//
//  Created by Andy on 2022/3/6.
//

import Foundation

public struct RawStockItem {
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
    
    public var displaySotckItem: DisplayStockItem {
        let closingPriceDouble = Double(closingPrice) ?? 0
        let lowestPrice = (closingPriceDouble * 0.9)
        let highestPrice = (closingPriceDouble * 1.1)
        
        let finalPrice = Double.random(in: lowestPrice...highestPrice)
        let dawnRaid = finalPrice - closingPriceDouble
        let range = (dawnRaid / closingPriceDouble) * 100
        
        
        return DisplayStockItem(code: code,
                                title: name,
                                finalPrice: String(format: "%.2f", finalPrice),
                                dawnRaid: String(format: "%.2f", dawnRaid),
                                range: String(format: "%.2f%%", range),
                                closingPrice: closingPrice)
    }
}

extension RawStockItem: Codable {
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


public struct DisplayStockItem {
    let code: String            //代號
    let title: String           //商品
    var finalPrice: String      //成交
    var dawnRaid: String        //漲跌
    var range: String           //幅度
    let closingPrice: String    //昨收價
    
    public init(code: String,
                title: String,
                finalPrice: String,
                dawnRaid: String,
                range: String,
                closingPrice: String) {
        self.code = code
        self.title = title
        self.finalPrice = finalPrice
        self.dawnRaid = dawnRaid
        self.range = range
        self.closingPrice = closingPrice
    }
    
    public var isLow: Bool {
        return dawnRaid.hasPrefix("-")
    }
}
