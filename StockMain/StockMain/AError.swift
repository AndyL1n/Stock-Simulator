//
//  AError.swift
//  StockMain
//
//  Created by Andy on 2022/3/6.
//

import Foundation

public enum AError: Error, Equatable {
    case `default`
    case jsonParsing
    case wrongUrl
    case custom(err: String)

    public var localizedDescription: String {
        switch self {
        case .jsonParsing:
            return "格式錯誤"
        case .wrongUrl:
            return "URL錯誤"
        case .custom(err: let msg):
            return msg
        default:
            return "錯誤"
        }
    }
}
