//
//  MVVMViewController.swift
//  MVC-MVVM
//
//  Created by 김민 on 2/20/24.
//

import UIKit

class MVVMViewController: UIViewController {
    private let timeView = TimeView()

    // MARK: - Properties
    let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        addTargets()

        viewModel.onUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.timeView.dateTimeLabel.text = self?.viewModel.dateTime
            }
        }

        viewModel.loadCurrentTime()
    }

    override func loadView() {
        self.view = timeView
    }

    // MARK: - Methods

    private func addTargets() {
        timeView.yesterdayButton.addTarget(self,
                                           action: #selector(tappedYesterdayButton),
                                           for: .touchUpInside)
        timeView.nowButton.addTarget(self,
                                     action: #selector(tappedNowButton),
                                     for: .touchUpInside)
        timeView.tomorrowButton.addTarget(self,
                                          action: #selector(tappedTomorrowButton),
                                          for: .touchUpInside)
    }
    
    // MARK: - @objc

    @objc private func tappedYesterdayButton() {
        viewModel.moveDay(-1)
    }

    @objc private func tappedNowButton() {
        viewModel.dateTime = "Loading..."
        viewModel.loadCurrentTime()
    }

    @objc private func tappedTomorrowButton() {
        viewModel.moveDay(1)
    }
}
