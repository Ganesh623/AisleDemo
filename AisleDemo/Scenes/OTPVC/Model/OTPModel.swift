//
//  OTPModel.swift
//  AisleDemo
//
//  Created by Ganesh N on 10/12/22.
//

import Foundation

struct OTPModel: Codable {
    var authToken: String?
    
    enum CodingKeys: String, CodingKey {
        case authToken = "token"
    }
}
