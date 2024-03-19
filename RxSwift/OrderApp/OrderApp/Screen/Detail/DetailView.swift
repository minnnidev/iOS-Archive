//
//  DetailView.swift
//  OrderApp
//
//  Created by 김민 on 3/6/24.
//

import UIKit
import SnapKit
import Then

class DetailView: UIView {

    let orderedItemsLabel = UILabel()
    let itemPriceLabel = UILabel()
    let vatPriceLabel = UILabel()
    let priceLabel = UILabel()
    private let itemTitleLabel = UILabel()
    private let priceTitleLabel = UILabel()
    private let itemPriceTitleLabel = UILabel()
    private let vatPriceTitleLabel = UILabel()
    private let lineView = UIView()


    override init(frame: CGRect) {
        super.init(frame: frame)

        setUI()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUI() {
        backgroundColor = .white

        itemTitleLabel.do {
            $0.text = "Ordered Items"
            $0.font = .systemFont(ofSize: 25, weight: .semibold)
        }

        orderedItemsLabel.do {
            $0.numberOfLines = 0 
            $0.font = .systemFont(ofSize: 20)
        }

        priceTitleLabel.do {
            $0.text = "Price to pay"
            $0.font = .systemFont(ofSize: 25, weight: .semibold)
        }

        itemPriceTitleLabel.do {
            $0.text = "Items"
            $0.font = .systemFont(ofSize: 25, weight: .regular)
        }

        vatPriceTitleLabel.do {
            $0.text = "VAT"
            $0.font = .systemFont(ofSize: 25, weight: .regular)
        }

        itemPriceLabel.do {
            $0.text = "₩\(700)"
        }

        vatPriceLabel.do {
            $0.text = "₩\(70)"
        }

        lineView.do { $0.backgroundColor = .systemGray5 }

        priceLabel.do {
            $0.text = "₩\(770)"
            $0.font = .systemFont(ofSize: 50, weight: .bold)
        }
    }

    private func setLayout() {
        [orderedItemsLabel, itemPriceLabel, vatPriceLabel, priceLabel, itemTitleLabel, priceTitleLabel, itemPriceTitleLabel, vatPriceTitleLabel, lineView].forEach {
            addSubview($0)
        }

        itemTitleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }

        orderedItemsLabel.snp.makeConstraints {
            $0.top.equalTo(itemTitleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(itemTitleLabel)
        }

        priceTitleLabel.snp.makeConstraints {
            $0.top.equalTo(orderedItemsLabel.snp.bottom).offset(30)
            $0.leading.equalTo(itemTitleLabel)
        }

        itemPriceTitleLabel.snp.makeConstraints {
            $0.top.equalTo(priceTitleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(itemTitleLabel)
        }

        itemPriceLabel.snp.makeConstraints {
            $0.centerY.equalTo(itemPriceTitleLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }

        vatPriceTitleLabel.snp.makeConstraints {
            $0.top.equalTo(itemPriceLabel.snp.bottom).offset(20)
            $0.leading.equalTo(itemTitleLabel)
        }

        vatPriceLabel.snp.makeConstraints {
            $0.centerY.equalTo(vatPriceTitleLabel)
            $0.trailing.equalTo(itemPriceLabel)
        }

        lineView.snp.makeConstraints {
            $0.top.equalTo(vatPriceLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(2)
        }

        priceLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(20)
            $0.trailing.equalTo(itemPriceLabel)
        }
    }
}
