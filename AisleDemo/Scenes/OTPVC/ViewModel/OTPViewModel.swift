//
//  OTPViewModel.swift
//  AisleDemo
//
//  Created by Ganesh N on 10/12/22.
//

import Foundation

class OTPViewModel {
    private var _enteredMobileStr: String?
    private var _authToken: String?
    private var _otpTimerInSec: Int = 120
    
    init(mobileStr: String) {
        self._enteredMobileStr = mobileStr
    }
    
    var enteredMobileStr: String {
        get { return _enteredMobileStr ?? "" }
    }
    
    var authToken: String {
        get { return _authToken ?? "" }
    }
    
    var otpTimerInSec: Int {
        get { return _otpTimerInSec }
        set {
            _otpTimerInSec = newValue
        }
    }
}

extension OTPViewModel {
    func verifyOtpAPICall(otpStr: String?, success: @escaping(Bool) -> Void, failure: @escaping(NetworkError) -> Void) {
        ///
        let apiUrl = AppConstants.baseUrl + AppConstants.otpPostEP
        let params: [String:Any] = ["number": self.enteredMobileStr, "otp": otpStr ?? ""]
        ///
        NetworkManager.shared.apiCall(urlString: apiUrl, params: params, http: .POST) { [weak self] (resultData) in
            switch resultData {
            case .success(let data):
                do {
                    let parsedData = try JSONDecoder().decode(OTPModel.self, from: data)
                    if let isAuthToken = parsedData.authToken {
                        self?._authToken = isAuthToken
                        DispatchQueue.main.async {
                            success(true)
                        }
                    } else {
                        DispatchQueue.main.async {
                            success(false)
                        }
                    }
                } catch {
                    debugPrint("Error while parsing data: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        success(false)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    failure(error)
                }
            }
        }
    }
}
