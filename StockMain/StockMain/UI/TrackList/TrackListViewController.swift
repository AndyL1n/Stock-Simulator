//
//  TrackListViewController.swift
//  StockMain
//
//  Created by Andy on 2022/3/6.
//

import UIKit

class TrackListViewController: UIViewController {
    @IBOutlet weak var sheetView: SpreadsheetView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    private var updateIndexPaths: [Int] = []
    private var viewModel: StockViewModel = {
        return StockViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.timer.invalidate()
    }

    private func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem (
            image: UIImage(named: "icon_setting"),
            style: .done, target: self, action: #selector(settingAction))
        
        sheetView.dataSource = self
        sheetView.register(StockTitleCell.self, forCellWithReuseIdentifier: StockTitleCell.id)
        sheetView.showsVerticalScrollIndicator = false
        sheetView.showsHorizontalScrollIndicator = false
        sheetView.bounces = false
        loadingIndicator.startAnimating()
        viewModel.getAllStockItems {
            self.sheetView.reloadData()
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.isHidden = true
        }
        viewModel.onUpdate = { indexs in
            self.updateIndexPaths = indexs
            self.sheetView.reloadData()
        }
    }
    
    @objc func settingAction() {
        let vc = SettingViewController.new(with: viewModel)
        present(vc, animated: true, completion: nil)
    }
}


extension TrackListViewController: SpreadsheetViewDataSource {
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        return 100
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        return row == 0 ? 40 : 60
    }
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int { //???
        return 7
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {   //???
        return viewModel.dataSource .count
    }
    
    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int { //???
        return 1
    }
    
    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {   //???
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
            case 6:     cell.config(with: item.updateTime, isTitle: isTitle)
            default:    break
            }
            if updateIndexPaths.contains(indexPath.item) {
                cell.flash()
            }
            return cell
        }
        return nil
    }
}


