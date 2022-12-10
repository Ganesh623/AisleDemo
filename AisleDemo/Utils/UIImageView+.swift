//
//  UIImageView+.swift
//  AisleDemo
//
//  Created by Ganesh N on 10/12/22.
//

import UIKit

extension UIImageView {
    // downloads & sets image on image view
    func downloadAndSetImage(from url: String?) {
        self.image =  #imageLiteral(resourceName: "ImgPlaceholder")
        guard let imgUrl = URL(string: url ?? "") else { return }
        ///
        DispatchQueue.global().async { [weak self] in
            if let imgData = try? Data(contentsOf: imgUrl) {
                if let image = UIImage(data: imgData) {
                    DispatchQueue.main.async { self?.image = image }
                }
            }
        }
    }
}
