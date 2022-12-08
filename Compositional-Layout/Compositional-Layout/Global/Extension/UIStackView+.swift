//
//  UIStackView+.swift
//  Compositional-Layout
//
//  Created by 김민 on 2022/12/08.
//

import UIKit

extension UIStackView {
    func addArrangedSubViews(_ views: UIView...) {
        views.forEach {  self.addArrangedSubview($0) }
    }
}
