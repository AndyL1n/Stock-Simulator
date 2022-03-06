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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
