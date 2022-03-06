//
//  TrackListViewController.swift
//  StockMain
//
//  Created by Andy on 2022/3/6.
//

import UIKit

class TrackListViewController: UIViewController {
    @IBOutlet weak var sheetView: SpreadsheetView!
    
    private var viewModel: StockViewModel = {
        return StockViewModel()
    }()
    
    
//    private var dataSource: [DisplayStockItem] = [DisplayStockItem(code: "代號",
//                                                                   title: "商品",
//                                                                   finalPrice: "成交",
//                                                                   dawnRaid: "漲跌",
//                                                                   range: "幅度",
//                                                                   closingPrice: "昨收價")]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        sheetView.dataSource = self
//        sheetView.register(UINib(nibName: "StockTitleCell", bundle: .main), forCellWithReuseIdentifier: StockTitleCell.id)
        sheetView.register(StockTitleCell.self, forCellWithReuseIdentifier: StockTitleCell.id)
        sheetView.bounces = false
        viewModel.getAllStockItems {
//            self.dataSource.append(contentsOf: self.viewModel.displayStoackItems)
            
            self.sheetView.reloadData()
        }
    }
}


extension TrackListViewController: SpreadsheetViewDataSource {
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        return 100
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        return row == 0 ? 40 : 60
    }
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int { //行
        return 6
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {   //列
//        return viewModel.displayStoackItems.count
        return viewModel.dataSource .count
    }
    
    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int { //行
        return 1
    }
    
    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {   //列
//        return viewModel.displayStoackItems.isEmpty ? 0 : 1
        return viewModel.dataSource.count == 1 ? 0 : 1
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        if let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: StockTitleCell.id, for: indexPath) as? StockTitleCell {
            let item = viewModel.dataSource[indexPath.item]
            let isTitle = indexPath.item == 0
            switch indexPath.column {
            case 0:     cell.config(with: item.title, isTitle: isTitle)
            case 1:     cell.config(with: item.code, isTitle: isTitle)
            case 2:     cell.config(with: item.finalPrice, textColor: item.isLow ? .green : .red, isTitle: isTitle)
            case 3:     cell.config(with: item.dawnRaid, textColor: item.isLow ? .green : .red, isTitle: isTitle)
            case 4:     cell.config(with: item.range, textColor: item.isLow ? .green : .red, isTitle: isTitle)
            case 5:     cell.config(with: item.closingPrice, isTitle: isTitle)
            default:    break
            }
            
            
            return cell
        }
        return nil
    }
}


