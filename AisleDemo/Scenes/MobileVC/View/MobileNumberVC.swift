//
//  MobileNumberVC.swift
//  AisleDemo
//
//  Created by Ganesh N on 10/12/22.
//

import UIKit

class MobileNumberVC: BaseVC {
    @IBOutlet weak var getOtpNameLabel: UILabel!
    @IBOutlet weak var countryCodeTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var continueBtnOutlet: UIButton!
    
    private var mobileVM: MobileViewModel!
    
    init(mobileVM: MobileViewModel) {
        self.mobileVM = mobileVM
        super.init(nibName: "MobileNumberVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///
        setNavBarUI()
        dummyUserData()
    }
    
    @IBAction func continueBtnAction(_ sender: Any) {
        view.endEditing(true)
        ///
        callingMobileAPI()
    }
}

// MARK: - Private Helpers -

extension MobileNumberVC {
    private func setNavBarUI() {
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func dummyUserData() {
        self.countryCodeTF.text = "+91"
        self.mobileTF.text = "9876543212"
    }
    
    private func moveToOTPVC() {
        let enteredMob = getEnteredMobile()
        let otpVC = OTPVC(otpVM: OTPViewModel(mobileStr: enteredMob))
        self.navigationController?.pushViewController(otpVC, animated: true)
    }
    
    private func getEnteredMobile() -> String {
        let countryCode = countryCodeTF.text ?? ""
        let mobileNum = mobileTF.text ?? ""
        ///
        return countryCode + mobileNum
    }
}

// MARK: - API Call -

extension MobileNumberVC {
    private func callingMobileAPI() {
        let enteredMob = getEnteredMobile()
        ///
        self.showSpinnerView()
        ///
        self.mobileVM.mobileNumAPICall(mobile: enteredMob) { [weak self] (isSuccess) in
            self?.hideSpinnerView()
            ///
            if (isSuccess) {
                DispatchQueue.main.async { self?.moveToOTPVC() }
            } else {
                self?.showAlert(with: "Error!", message: "Enter correct details and try again.")
            }
        } failure: { (error) in
            self.hideSpinnerView()
            debugPrint(error.errorDescription ?? "")
            self.showAlert(with: "Error!", message: "Something went wrong, try again later.")
        }
    }
}
