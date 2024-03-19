//
//  ItemTableViewCell.swift
//  OrderApp
//
//  Created by 김민 on 3/6/24.
//

import UIKit
import SnapKit
import Then

class ItemTableViewCell: UITableViewCell {

    private let plusButton = UIButton()
    private let minusButton = UIButton()
    private let itemNameLabel = UILabel()
    private let itemCountLabel = UILabel()
    private let priceLabel = UILabel()

    var onCountChanged: ((Int) -> ())?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUI()
        setLayout()
        addTargets()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUI() {
        selectionStyle = .none

        plusButton.do {
            $0.setImage(UIImage(systemName: "plus"), for: .normal)
            $0.tintColor = .systemGray2
        }

        minusButton.do {
            $0.setImage(UIImage(systemName: "minus"), for: .normal)
            $0.tintColor = .systemGray2
        }

        itemNameLabel.do { $0.font = .systemFont(ofSize: 20) }
        itemCountLabel.do { $0.textColor = .systemPink }
        priceLabel.do { $0.text = "200" }
    }

    private func setLayout() {
        [plusButton, minusButton, itemNameLabel, itemCountLabel, priceLabel].forEach {
            contentView.addSubview($0)
        }

        plusButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }

        minusButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(plusButton.snp.trailing).offset(15)
        }

        itemNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(minusButton.snp.trailing).offset(20)
        }

        itemCountLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(itemNameLabel.snp.trailing).offset(15)
        }

        priceLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
        }
    }

    func dataBind(_ menu: Menu, _ count: Int) {
        itemNameLabel.text = menu.name
        priceLabel.text = "\(menu.price)"
        itemCountLabel.text = "(\(count))"
    }

    func addTargets() {
        plusButton.addTarget(self, 
                             action: #selector(tappedPlusButton),
                             for: .touchUpInside)
        minusButton.addTarget(self, 
                              action: #selector(tappedMinusButton),
                              for: .touchUpInside)
    }

    @objc private func tappedPlusButton() {
        onCountChanged?(1)
    }

    @objc private func tappedMinusButton() {
        onCountChanged?(-1)
    }
}
