//
//  StockTitleCell.swift
//  StockMain
//
//  Created by Andy on 2022/3/6.
//

import UIKit

class StockTitleCell: Cell {
    static let id = "StockTitleCellID"

    private var label = UILabel()
    
    private var vvv = UIView()
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.backgroundColor = .clear
        contentView.addSubview(label)
        
//        vvv.frame = bounds
//        vvv.backgroundColor = .blue
//        contentView.addSubview(vvv)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func config(with title: String, textColor: UIColor = .white, isTitle: Bool = false) {
        label.text = title
        label.textColor = isTitle ? .white : textColor
        contentView.backgroundColor = isTitle ? .gray : .black
    }
    
    public func flash() {
        borders.bottom = .solid(width: 3, color: .red)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001, execute: {
////            self.borders.bottom = .none
//            self.borders = .init(top: .none, bottom: .none, left: .none, right: .none)
//        })
    }
}
