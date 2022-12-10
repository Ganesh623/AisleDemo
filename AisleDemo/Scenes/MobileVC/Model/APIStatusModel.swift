//
//  APIStatusModel.swift
//  AisleDemo
//
//  Created by Ganesh N on 10/12/22.
//

import Foundation

struct APIStatusModel: Codable {
    var _status: Bool?
    
    enum CodingKeys: String, CodingKey {
        case _status = "status"
    }
}
