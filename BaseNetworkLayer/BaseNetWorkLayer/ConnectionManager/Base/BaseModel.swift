//
//  BaseModel.swift
//  BaseNetworkLayer
//
//  Created by Nguyễn Hoàng on 20/08/2022.
//

import Foundation
import Alamofire

protocol BaseResponse: Codable {
    var code: Int { get set }
    var message: String? { get set}
}

struct BaseResponseModel: BaseResponse {
    var code: Int
    var message: String?
}

struct BaseResponseContainer<T: Codable>: BaseResponse {
    var code: Int
    var message: String?
    var data: T?
}
