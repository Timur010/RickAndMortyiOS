//
//  Extensions.swift
//  RickAndMorty
//
//  Created by timur on 09.02.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
