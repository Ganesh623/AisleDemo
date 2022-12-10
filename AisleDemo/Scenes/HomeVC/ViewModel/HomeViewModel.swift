//
//  HomeViewModel.swift
//  AisleDemo
//
//  Created by Ganesh N on 10/12/22.
//

import Foundation

enum BrandPhotos {
    static var mainImage: String = ""
    static var dummyImg1: String = ""
    static var dummyImg2: String = ""
}

class HomeViewModel {
    private var _authToken: String?
    private var dataModel: HomeModel?
    
    init(authToken: String) {
        self._authToken = authToken
    }
    
    func processBrandImages(completion: @escaping(Bool) -> Void) {
        let invitePhoto = dataModel?.invites?.profiles?.first?.photos?.first?.photo
        let dummy1 = dataModel?.likes?.profiles?.first?.avatar
        let dummy2 = dataModel?.likes?.profiles?.last?.avatar
        
        if let invitePhoto = invitePhoto, let dummy1 = dummy1, let dummy2 = dummy2 {
            BrandPhotos.mainImage = invitePhoto
            BrandPhotos.dummyImg1 = dummy1
            BrandPhotos.dummyImg2 = dummy2
            completion(true)
        } else {
            completion(false)
        }
    }
}

extension HomeViewModel {
    func notesAPICall(success: @escaping(Bool) -> Void, failure: @escaping(NetworkError) -> Void) {
        ///
        let apiUrl = AppConstants.baseUrl + AppConstants.notesGetEP
        let authToken = _authToken ?? ""
        ///
        NetworkManager.shared.apiCall(urlString: apiUrl, params: [:], http: .GET, authToken) { [weak self] (resultData) in
            switch resultData {
            case .success(let data):
                do {
                    let parsedData = try JSONDecoder().decode(HomeModel.self, from: data)
                    if (parsedData.invites != nil) {
                        self?.dataModel = parsedData
                        DispatchQueue.main.async { success(true) }
                    } else {
                        DispatchQueue.main.async { success(false) }
                    }
                } catch {
                    debugPrint("Error while parsing data: \(error.localizedDescription)")
                    DispatchQueue.main.async { success(false) }
                }
            case .failure(let error):
                DispatchQueue.main.async { failure(error) }
            }
        }
    }
}
