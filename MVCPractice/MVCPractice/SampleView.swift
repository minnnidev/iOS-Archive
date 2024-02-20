//
//  SampleView.swift
//  MVCPractice
//
//  Created by 김민 on 2/19/24.
//

import UIKit
import SnapKit
import Then

class SampleView: UIView {

    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setLayout()
        setUI()
    }

    private func setLayout() {
        [nameLabel, descriptionLabel].forEach {
            self.addSubview($0)
        }

        nameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalTo(nameLabel)
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
        }
    }

    private func setUI() {
        self.backgroundColor = .white

        nameLabel.do {
            $0.text = "밍김"
            $0.font = .systemFont(ofSize: 30, weight: .bold)
        }

        descriptionLabel.do {
            $0.text = """
                    안녕하세요 iOS 개발자 밍김입니다.\n저는 25살입니다.\n잘 부탁드립니다 ✨
                    """
            $0.numberOfLines = 0
            $0.textAlignment = .center
        }
    }
}
