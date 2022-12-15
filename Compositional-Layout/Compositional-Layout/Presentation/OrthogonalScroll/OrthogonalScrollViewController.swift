//
//  OrthogonalScrollViewController.swift
//  Compositional-Layout
//
//  Created by 김민 on 2022/12/15.
//

import UIKit

import SnapKit
import Then

// MARK: - OrthogonalScrollViewController

class OrthogonalScrollViewController: UIViewController {
    
    // MARK: - Enum
    
    enum Section {
        case one, two, three
    }
    
    // MARK: - Variable
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    
    // MARK: - UI Component
    
    private lazy var scrollCollectionView: UICollectionView = {
        let layout = createLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .yellow
        
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

extension OrthogonalScrollViewController {
    
    // MARK: - Layout
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let leadingItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                                  heightDimension: .fractionalHeight(1.0)))
            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

            let trailingItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(0.3)))
            trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
   
            let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize:
                                    NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                    heightDimension: .fractionalHeight(1.0)),
                                    repeatingSubitem: trailingItem,
                                    count: 2)

            let containerGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
                                                   heightDimension: .absolute(300)),
                subitems: [leadingItem, trailingGroup])
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.orthogonalScrollingBehavior = .continuous

            return section

        }
        return layout
    }
    
    private func setLayout() {
        view.addSubview(scrollCollectionView)
        
        scrollCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Config
    
    private func config() {
        view.backgroundColor = .white
        
        let cellRegisteration = UICollectionView.CellRegistration<NestedCollectionViewCell, Int> { cell, indexPath, itemIdentifier in
            cell.nameLabel.text = "\(itemIdentifier)"
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: scrollCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: itemIdentifier)
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.one, .two, .three])
        snapshot.appendItems(Array(0..<10), toSection: .one)
        snapshot.appendItems(Array(10..<20), toSection: .two)
        snapshot.appendItems(Array(20..<30), toSection: .three)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
