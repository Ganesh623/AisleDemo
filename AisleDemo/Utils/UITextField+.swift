//
//  UITextField+.swift
//  AisleDemo
//
//  Created by Ganesh N on 10/12/22.
//

import UIKit

private var maxLengths = [UITextField: Int]()

extension UITextField {
    
    // MARK: - Maximum length -
    
    @IBInspectable var maxLength: Int {
        get {
            guard let length = maxLengths[self] else {
                return 100
            }
            return length
        }
        set {
            maxLengths[self] = newValue
            addTarget(self, action: #selector(fixMax), for: .editingChanged)
        }
    }
    
    @objc func fixMax(textField: UITextField) {
        let text = textField.text
        textField.text = text?.safelyLimitedTo(length: maxLength)
    }
}

extension String {
    func safelyLimitedTo(length n: Int)->String {
        if (self.count <= n) {
            return self
        }
        return String( Array(self).prefix(upTo: n) )
    }
    
    func safelyLimitedFrom(length n: Int)->String {
        if (self.count <= n) {
            return self
        }
        return String( Array(self).prefix(upTo: n) )
    }
}
