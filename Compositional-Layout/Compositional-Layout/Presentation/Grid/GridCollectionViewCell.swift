//
//  GridCollectionViewCell.swift
//  Compositional-Layout
//
//  Created by 김민 on 2022/12/08.
//

import UIKit

import SnapKit
import Then

// MARK: - GridCollectionViewCell

class GridCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Identifier
    
    static let identifier = "GridCollectionViewCell"
    
    // MARK: - UI Component
    
    let nameLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extension

extension GridCollectionViewCell {
    
    // MARK: - Layout
    
    private func setLayout() {
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Config
    
    private func config() {
        contentView.backgroundColor = .cyan
    }
}
