//
//  StaffModel.swift
//  BaseNetworkLayer
//
//  Created by Nguyễn Hoàng on 20/08/2022.
//

import Foundation

struct EmployeeResponse: Codable {
    let employees: [EmployeeModel]
}

struct EmployeeModel: Codable {
    var _id: String
    var createdAt: String
    var name: String
    var avatar: String
    var address: String
    var isMale: Bool
    var status: Int
    var dayWorking: Int
    
    enum CodingKeys: String, CodingKey {
        case _id = "id", createdAt, name, avatar, address, isMale, status, dayWorking
    }
}
