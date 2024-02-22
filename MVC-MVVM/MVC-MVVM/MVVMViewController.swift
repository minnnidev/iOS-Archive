//
//  MVVMViewController.swift
//  MVC-MVVM
//
//  Created by 김민 on 2/20/24.
//

import UIKit
import RxSwift
import RxCocoa

class MVVMViewController: UIViewController {

    private let timeView = TimeView()

    let viewModel = ViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        addTargets()
//
//        viewModel.dateTime
//            .observe(on: MainScheduler.instance)
//            .subscribe { [weak self] in
//                self?.timeView.dateTimeLabel.text = $0
//            }
//            .disposed(by: disposeBag)

        viewModel.dateTime
            .bind(to: timeView.dateTimeLabel.rx.text)
            .disposed(by: disposeBag)

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
        viewModel.loadCurrentTime()
    }

    @objc private func tappedTomorrowButton() {
        viewModel.moveDay(1)
    }
}
