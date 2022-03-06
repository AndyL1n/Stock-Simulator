//
//  UIStoryboard+extension.swift
//  StockMain
//
//  Created by Andy on 2022/3/6.
//

import UIKit

extension UIStoryboard {
    public static var Main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: .main)
    }
        
    public func newInstance<T: UIViewController>(typeName: String) -> T {
        return self.instantiateViewController(withIdentifier: typeName) as! T
    }
}
