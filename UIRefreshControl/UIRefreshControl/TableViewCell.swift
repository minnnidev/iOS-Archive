//
//  TableViewCell.swift
//  UIRefreshControl
//
//  Created by 김민 on 2023/06/25.
//

import UIKit

import SnapKit
import Then

final class TableViewCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "TableViewCell"

    // MARK: - UI Components

    private let numberLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
    }

    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setBackgroundColor()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TableViewCell {

    // MARK: - Custom Methods

    private func setBackgroundColor() {
        backgroundColor = .clear
    }

    private func setLayout() {
        addSubview(numberLabel)

        numberLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    func setDataBind(_ name: String) {
        numberLabel.text = name
    }
}
