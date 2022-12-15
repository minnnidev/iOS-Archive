//
//  NestedGroupViewController.swift
//  Compositional-Layout
//
//  Created by 김민 on 2022/12/15.
//

import UIKit

import SnapKit
import Then

// MARK: - NestedGroupViewController

class NestedGroupViewController: UIViewController {
    
    // MARK: - Enum
    
    enum Section {
        case main
    }
    
    // MARK: - UI Component
    
    private lazy var nestedCollectionView: UICollectionView = {
        let layout = createLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .yellow
        
        return collectionView
    }()
    
    // MARK: - Variable
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        config()
    }
}

// MARK: - Extension

extension NestedGroupViewController {
    
    // MARK: - Layout
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionInt, layoutEnvironment) -> NSCollectionLayoutSection? in
            let leadingItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                         heightDimension: .fractionalHeight(1.0))
            let leadingItem = NSCollectionLayoutItem(layoutSize: leadingItemSize)
            
            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let trailingItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                          heightDimension: .fractionalWidth(0.5))
            let trailingItem = NSCollectionLayoutItem(layoutSize: trailingItemSize)
            
            trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let trailingGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                           heightDimension: .fractionalHeight(1.0))
            let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: trailingGroupSize, repeatingSubitem: trailingItem, count: 2)
            
            let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                         heightDimension: .absolute(300))
            let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: nestedGroupSize, subitems: [leadingItem, trailingGroup])
            
            let section = NSCollectionLayoutSection(group: nestedGroup)
            
            return section
        }
        return layout
    }
    
    private func setLayout() {
        
        view.addSubview(nestedCollectionView)
        
        nestedCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Config
    
    private func config() {
        
        view.backgroundColor = .white
        
        let cellRegisteration = UICollectionView.CellRegistration<NestedCollectionViewCell, Int> { cell, indexPath, itemIdentifier in
            print(itemIdentifier)
            cell.nameLabel.text = "\(itemIdentifier)"
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: nestedCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: itemIdentifier)
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0..<100))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
