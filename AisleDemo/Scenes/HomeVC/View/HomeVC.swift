//
//  HomeVC.swift
//  AisleDemo
//
//  Created by Ganesh N on 10/12/22.
//

import UIKit

class HomeVC: BaseVC {
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var bottomImgRight: UIImageView!
    @IBOutlet weak var bottomImgLeft: UIImageView!
    
    private var homeVM: HomeViewModel!
    
    init(homeVM: HomeViewModel) {
        self.homeVM = homeVM
        super.init(nibName: "HomeVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///
        callNotesAPI()
    }
}

// MARK: - Private Methods -

extension HomeVC {
    private func loadTheImages() {
        homeVM.processBrandImages { [weak self] (isAvailable) in
            if !isAvailable {
                self?.showAlert(with: "Error!", message: "Something went wrong, try again later.")
            }
            else {
                DispatchQueue.main.async { self?.setBrandImgs() }
            }
        }
    }
    
    private func setBrandImgs() {
        mainImage.downloadAndSetImage(from: BrandPhotos.mainImage)
        bottomImgLeft.downloadAndSetImage(from: BrandPhotos.dummyImg1)
        bottomImgRight.downloadAndSetImage(from: BrandPhotos.dummyImg2)
    }
}

// MARK: - API Calls -

extension HomeVC {
    private func callNotesAPI() {
        self.showSpinnerView()
        ///
        self.homeVM.notesAPICall { [weak self] (isSuccess) in
            self?.hideSpinnerView()
            ///
            if (isSuccess) {
                DispatchQueue.main.async { self?.loadTheImages() }
            } else {
                self?.showAlert(with: "Error!", message: "Enter correct OTP and try again.")
            }
        } failure: { (error) in
            self.hideSpinnerView()
            debugPrint(error.errorDescription ?? "")
            self.showAlert(with: "Error!", message: "Something went wrong, try again later.")
        }
    }
}
