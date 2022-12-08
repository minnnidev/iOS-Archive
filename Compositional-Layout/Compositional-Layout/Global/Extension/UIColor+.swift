//
//  UIColor+.swift
//  Compositional-Layout
//
//  Created by 김민 on 2022/12/08.
//

import UIKit

extension UIColor {
    convenience init(r: Int, g: Int, b: Int) {
        self.init(red: CGFloat(r)/255,green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1)
    }
}
