//
//  Constants.swift
//  AisleDemo
//
//  Created by Ganesh N on 10/12/22.
//

import Foundation

enum AppConstants {
    static let baseUrl = "https://testa2.aisle.co/V1/"
    static let mobilePostEP = "users/phone_number_login"
    static let otpPostEP = "users/verify_otp"
    static let notesGetEP = "users/test_profile_list"
}

enum HTTP_Methods: String {
    case POST = "POST"
    case GET = "GET"
}
