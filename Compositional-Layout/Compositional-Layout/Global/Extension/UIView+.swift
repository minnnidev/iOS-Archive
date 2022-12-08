//
//  UIView+.swift
//  Compositional-Layout
//
//  Created by 김민 on 2022/12/08.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
