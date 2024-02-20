//
//  TimeView.swift
//  MVC-MVVM
//
//  Created by 김민 on 2/20/24.
//

import UIKit
import SnapKit
import Then

class TimeView: UIView {
    let dateTimeLabel = UILabel()
    let yesterdayButton = UIButton()
    let nowButton = UIButton()
    let tomorrowButton = UIButton()
    private let buttonStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUI() {
        self.backgroundColor = .white

        dateTimeLabel.do {
            $0.text = "0000년 00월 00일 00시 00분"
            $0.font = .systemFont(ofSize: 20, weight: .bold)
        }

        yesterdayButton.do {
            $0.setTitle("Yesterday", for: .normal)
            $0.setTitleColor(.systemBlue, for: .normal)
        }

        nowButton.do {
            $0.setTitle("Now", for: .normal)
            $0.setTitleColor(.systemBlue, for: .normal)
        }

        tomorrowButton.do {
            $0.setTitle("Tomorrow", for: .normal)
            $0.setTitleColor(.systemBlue, for: .normal)
        }

        buttonStackView.do {
            $0.spacing = 10
        }
    }

    private func setLayout() {
        [yesterdayButton, nowButton, tomorrowButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }

        [dateTimeLabel, buttonStackView].forEach {
            addSubview($0)
        }

        dateTimeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(dateTimeLabel.snp.bottom).offset(10)
        }
    }
}
