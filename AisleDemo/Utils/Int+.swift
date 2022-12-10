//
//  Int+.swift
//  AisleDemo
//
//  Created by Ganesh N on 10/12/22.
//

import Foundation

extension Int {
    func convertToMM_SS() -> String {
        guard (self >= 0) else { return "" }
        ///
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
}
