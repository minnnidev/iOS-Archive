//
//  GridViewController.swift
//  Compositional-Layout
//
//  Created by 김민 on 2022/12/08.
//

import UIKit

import SnapKit
import Then

// MARK: - GridViewController

class GridViewController: UIViewController {
    
    // MARK: - Enum
    
    enum Section {
        case main
    }
    
    // MARK: - Variable
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    
    // MARK: - UI Component
    
    private lazy var gridCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        
        return collectionView
    }()
    
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        setLayout()
    }
}

// MARK: - Extension

extension GridViewController {
    
    // MARK: - Layout
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    private func setLayout() {
        view.addSubview(gridCollectionView)
        
        gridCollectionView.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Config
    
    private func config() {
        view.backgroundColor = .white
        
        let cellRegisteration = UICollectionView.CellRegistration<GridCollectionViewCell, Int> { cell, indexPath, itemIdentifier in
            cell.nameLabel.text = "\(itemIdentifier)"
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: gridCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: itemIdentifier)
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0..<90))
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
