//
//  MobileViewModel.swift
//  AisleDemo
//
//  Created by Ganesh N on 10/12/22.
//

import Foundation

class MobileViewModel {
    init() {
    }
}


extension MobileViewModel {
    func mobileNumAPICall(mobile: String?, success: @escaping(Bool) -> Void, failure: @escaping(NetworkError) -> Void) {
        ///
        let apiUrl = AppConstants.baseUrl + AppConstants.mobilePostEP
        let params: [String:Any] = ["number": mobile ?? ""]
        ///
        NetworkManager.shared.apiCall(urlString: apiUrl, params: params, http: .POST) { (resultData) in
            switch resultData {
            case .success(let data):
                do {
                    let parsedData = try JSONDecoder().decode(APIStatusModel.self, from: data)
                    let isAPISuccess = parsedData._status ?? false
                    DispatchQueue.main.async {
                        success(isAPISuccess)
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
