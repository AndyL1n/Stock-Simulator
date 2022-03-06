//
//  StockTitleCell.swift
//  StockMain
//
//  Created by Andy on 2022/3/6.
//

import UIKit

class StockTitleCell: Cell {
    static let id = "StockTitleCellID"

    var label = UILabel()
    
    override func setup() {
        super.setup()
        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.backgroundColor = .clear
        contentView.addSubview(label)
    }
    
    public func config(with title: String, textColor: UIColor = .white, isTitle: Bool = false) {
        label.text = title
        label.textColor = isTitle ? .white : textColor
        contentView.backgroundColor = isTitle ? .gray : .black
    }
}
