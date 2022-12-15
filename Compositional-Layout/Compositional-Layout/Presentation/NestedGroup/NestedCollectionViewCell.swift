//
//  NestedCollectionViewCell.swift
//  Compositional-Layout
//
//  Created by 김민 on 2022/12/15.
//

import UIKit

// MARK: - NestedCollectionViewCell

class NestedCollectionViewCell: UICollectionViewCell {
    
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

extension NestedCollectionViewCell {
    
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
