//
//  NetworkManager.swift
//  AisleDemo
//
//  Created by Ganesh N on 10/12/22.
//

import Foundation

// MARK: - Network Manager -

class NetworkManager {
    
    static var shared = NetworkManager()
    
    func apiCall(urlString: String, params: [String: Any], http: HTTP_Methods, _ authorization: String = "", completionHandler: @escaping(Result<Data, NetworkError>) -> Void) {
        ///
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badRequest))
            return
        }
        ///
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = http.rawValue
        urlReq.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        if !authorization.isEmpty {
            urlReq.setValue("\(authorization)", forHTTPHeaderField: "Authorization")
        }
        ///
        if !params.isEmpty {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
                return
            }
            urlReq.httpBody = httpBody
        }
        ///
        URLSession.shared.dataTask(with: urlReq) { (data, response, error) in
            if error != nil, let er = error as? NetworkError {
                completionHandler(.failure(er))
                return
            }
            ///
            guard let userData = data, let urlResponse = response, (urlResponse as? HTTPURLResponse)?.statusCode == 200 else {
                completionHandler(.failure(.defaultError))
                return
            }
            ///
            completionHandler(.success(userData))
        }
        .resume()
    }
}

/**
 Network Error Enum with multiple cases of API Failures.
 */
enum NetworkError: Error {
    case badRequest
    case parsingError
    case defaultError
}

/**
 Localized Description for the Network Error.
 */
extension NetworkError: LocalizedError {
    ///
    public var errorDescription: String? {
        switch self {
        case .badRequest:
            return NSLocalizedString("Invalid request Passed", comment: "")
        case .parsingError:
            return NSLocalizedString("An error occured while parsing data Passed", comment: "")
        case .defaultError:
            return NSLocalizedString("An error occured while processing data", comment: "")
        }
    }
}
