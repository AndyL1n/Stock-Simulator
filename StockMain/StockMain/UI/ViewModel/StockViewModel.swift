//
//  StockViewModel.swift
//  StockMain
//
//  Created by Andy on 2022/3/6.
//

import Foundation
import Alamofire

public class StockViewModel {
    private let jsonFormatRequest: String = "https://quality.data.gov.tw/dq_download_json.php?nid=11549&md5_url=da96048521360db9f23a2b47c9c31155"
    
    private var allStockItems: [RawStockItem] = [] {
        didSet {
            let unsortedList = allStockItems.filter { defaultCompanyList.contains($0.code) }
            displayStoackItems = unsortedList.sorted(by: { defaultCompanyList.firstIndex(of: $0.code)! < defaultCompanyList.firstIndex(of: $1.code)!}).map{ $0.displaySotckItem }
            dataSource.append(contentsOf: displayStoackItems)
        }
    }
    
    private var displayStoackItems: [DisplayStockItem] = []
    
    public var dataSource: [DisplayStockItem] = [DisplayStockItem(code: "代號",
                                                                  title: "商品",
                                                                  finalPrice: "成交",
                                                                  dawnRaid: "漲跌",
                                                                  range: "幅度",
                                                                  closingPrice: "昨收價")]
    
    private let defaultCompanyList: [String] = {
        do {
            let rawData = try Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "defaultCompany", ofType: "json")!))
            let data = try JSONDecoder().decode([[String]].self, from: rawData)
            return data.map{ $0.first ?? "" }
        } catch let error {
            return []
        }
    }()
    
    init() {
    }
    
    public func getAllStockItems(complete: @escaping () -> Void) {
        downloadTodayList {
            switch $0 {
            case .success(let items):
                self.allStockItems = items
            case .failure(let error):
                debugPrint(error)
            }
            complete()
        }
    }
    
    private func downloadTodayList(complete: @escaping (Result<([RawStockItem]), AError>) -> Void) {
        AF.download(jsonFormatRequest).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    var url = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                    url = url.appendingPathComponent("stock.json")
                    try data.write(to: url, options: .completeFileProtection)
                    let rawData = try Data(contentsOf: url)
                    let items = try JSONDecoder().decode([RawStockItem].self, from: rawData)
                    complete(.success(items))
                } catch let error {
                    complete(.failure(.custom(err: error.localizedDescription)))
                }
            case .failure(let error):
                complete(.failure(.custom(err: error.localizedDescription)))
            }
        }
    }
}
