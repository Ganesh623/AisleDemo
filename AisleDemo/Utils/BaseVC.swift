//
//  BaseVC.swift
//  AisleDemo
//
//  Created by Ganesh N on 10/12/22.
//

import UIKit

class BaseVC: UIViewController {
    let child = SpinnerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///
        addTapGestureTo(thisView: self.view)
    }
}

// MARK: - Tap gesture -

extension BaseVC {
    func addTapGestureTo(thisView: UIView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedMainView))
        thisView.addGestureRecognizer(tap)
    }
    
    @objc func tappedMainView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}

// MARK: - Nav Bar -

extension BaseVC {
    func setNavTitle(with titleStr: String) {
        guard let navigationController = navigationController else { return }
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.isNavigationBarHidden = false
        navigationItem.title = titleStr
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController.navigationBar.sizeToFit()
    }
}

// MARK: - Activity Indicator -

extension BaseVC {
    func showSpinnerView() {
        /// add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func hideSpinnerView() {
        /// remove the spinner view controller
        DispatchQueue.main.async {
            self.child.willMove(toParent: nil)
            self.child.view.removeFromSuperview()
            self.child.removeFromParent()
        }
    }
}

// MARK: - Show Alert -

extension BaseVC {
    /// Show Alert with Error Message.
    func showAlert(with title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true, completion: nil)
    }
}

// MARK: - Spinner Controller -

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .large)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.15)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
