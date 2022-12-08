//
//  ViewController.swift
//  Compositional-Layout
//
//  Created by 김민 on 2022/12/08.
//

import UIKit

import SnapKit
import Then

// MARK: - ListViewController

class ListViewController: UIViewController {
    
    // MARK: - Enum
    
    enum Section {
        case main
    }
    
    // MARK: - Variable
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    
    // MARK: - UI Component
    
    private lazy var listCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        config()
    }
}

// MARK: - Extension

extension ListViewController {
    
    // MARK: - Layout
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func setLayout() {
        view.addSubview(listCollectionView)
        
        listCollectionView.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Config
    
    private func config() {
        view.backgroundColor = .white
        
        let cellRegisteration = UICollectionView.CellRegistration<ListCollectionViewCell, Int> { cell, indexPath, itemIdentifier in
            cell.dataBind(text: String(itemIdentifier))
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: listCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: itemIdentifier)
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0..<90))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

