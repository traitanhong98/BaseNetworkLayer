//
//  Dict+Extensions.swift
//  BaseNetworkLayer
//
//  Created by Nguyễn Hoàng on 20/08/2022.
//

import Foundation

extension Dictionary {
    static func +=(lhs: inout [Key: Value], rhs: [Key: Value]) {
        for (k, v) in rhs {
            lhs.updateValue(v, forKey: k)
        }
    }
    
    static func +(lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value]{
        var result = [Key: Value]()
        for (k, v) in lhs {
            result.updateValue(v, forKey: k)
        }
        
        for (k, v) in rhs {
            result.updateValue(v, forKey: k)
        }
        
        return result
    }
}
