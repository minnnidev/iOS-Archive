//
//  OrderView.swift
//  OrderApp
//
//  Created by 김민 on 3/6/24.
//

import UIKit

class OrderView: UIView {

    let tableView = UITableView(frame: .zero, style: .plain)
    let orderButton = UIButton()
    let clearButton = UIButton()
    private let orderView = UIView()
    private let orderLabel = UILabel()
    let itemCountLabel = UILabel()
    let priceLabel = UILabel()

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

        orderView.do {
            $0.backgroundColor = .systemGray4
        }

        orderButton.do {
            $0.backgroundColor = .black
            $0.setTitle("Order", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        }

        orderLabel.do {
            $0.text = "Your Orders"
        }

        clearButton.do {
            $0.setTitle("Clear", for: .normal)
        }

        itemCountLabel.do { $0.textColor = .systemPink }
        priceLabel.do { $0.font = .systemFont(ofSize: 50, weight: .bold) }
    }

    private func setLayout() {
        [tableView, orderView, orderButton].forEach {
            addSubview($0)
        }

        [orderLabel, clearButton, itemCountLabel, priceLabel].forEach {
            orderView.addSubview($0)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(orderView.snp.top)
        }

        orderView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
            $0.bottom.equalTo(orderButton.snp.top)
        }

        orderLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalToSuperview().offset(15)
        }

        clearButton.snp.makeConstraints {
            $0.leading.equalTo(orderLabel.snp.trailing).offset(20)
            $0.centerY.equalTo(orderLabel)
        }

        itemCountLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-15)
            $0.centerY.equalTo(orderLabel)
        }

        priceLabel.snp.makeConstraints {
            $0.trailing.equalTo(itemCountLabel)
            $0.bottom.equalToSuperview().offset(-15)
        }

        orderButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(60)
        }
    }
}
