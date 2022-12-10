//
//  OTPVC.swift
//  AisleDemo
//
//  Created by Ganesh N on 10/12/22.
//

import UIKit

class OTPVC: BaseVC {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var editBtnOutlet: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var continueBtnOutlet: UIButton!
    @IBOutlet weak var otpTF: UITextField!
    
    private var otpVM: OTPViewModel!
    private var otpTimer = Timer()
    
    init(otpVM: OTPViewModel) {
        self.otpVM = otpVM
        super.init(nibName: "OTPVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    @IBAction func editBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueBtnAction(_ sender: Any) {
        view.endEditing(true)
        self.callingVerifyOtpAPI()
    }
}

// MARK: - Private Methods -

extension OTPVC {
    private func setUI() {
        ///
        mobileLabel.text = otpVM.enteredMobileStr
        otpTF.text = "1234"     /// Dummy OTP
        ///
        setupOtpTimer()
    }
    
    private func rootedMainTab() {
        let mainTab = MainTabVC(authorization: otpVM.authToken)
        self.view.window?.rootViewController = mainTab
        self.view.window?.makeKeyAndVisible()
    }
    
    /// OTP Timer setup
    private func setupOtpTimer() {
        otpTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimerLabel), userInfo: nil, repeats: true)
    }
    
    /// Action of timer for every second in loop.
    @objc func updateTimerLabel() {
        otpVM.otpTimerInSec -= 1
        if otpVM.otpTimerInSec == 0 {
            otpTimer.invalidate()
            otpVM.otpTimerInSec = 120       /// Reset the value
        } else {
            let timeInMMSS = otpVM.otpTimerInSec.convertToMM_SS()
            timerLabel.text = "\(timeInMMSS)"
        }
    }
}

// MARK: - API Calls -

extension OTPVC {
    private func callingVerifyOtpAPI() {
        let enteredOTP = otpTF.text ?? ""
        ///
        self.showSpinnerView()
        ///
        self.otpVM.verifyOtpAPICall(otpStr: enteredOTP) { [weak self] (isSuccess) in
            self?.hideSpinnerView()
            ///
            if (isSuccess) {
                DispatchQueue.main.async { self?.rootedMainTab() }
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
