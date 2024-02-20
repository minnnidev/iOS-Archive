//
//  SampleViewController.swift
//  MVCPractice
//
//  Created by 김민 on 2/19/24.
//

import UIKit

class SampleViewController: UIViewController {

    private var customView = SampleView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        self.view = customView
    }
}
