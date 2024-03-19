//
//  BaseViewController.swift
//  OrderApp
//
//  Created by 김민 on 3/6/24.
//

import UIKit

class BaseViewController<BaseView: UIView>: UIViewController {

    var baseView = BaseView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        self.view = baseView
    }
}
