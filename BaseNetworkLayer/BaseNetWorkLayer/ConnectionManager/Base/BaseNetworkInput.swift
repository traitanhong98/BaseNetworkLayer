//
//  BaseNetworkInput.swift
//  BaseNetworkLayer
//
//  Created by Nguyễn Hoàng on 20/08/2022.
//

import Foundation
import Alamofire



class BaseNetworkInput {
    static var baseParam: [String: Any] {
        [:]
    }
    /// For common header
    static func getHeaders() -> HTTPHeaders? {
        nil
    }
    /// Adding common param to requestParam
    static func getParam(formDict dict: [String: Any]) -> [String: Any] {
        return baseParam + dict
    }
}
