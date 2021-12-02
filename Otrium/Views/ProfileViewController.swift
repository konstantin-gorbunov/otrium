//
//  ProfileViewController.swift
//  Otrium
//
//  Created by Kostiantyn Gorbunov on 29/11/2021.
//

import UIKit

protocol ProfileViewControllabel: AnyObject {
    func refresh(_ sender: ProfileViewController)
}

class ProfileViewController: UICollectionViewController {
    
    weak var delegate: ProfileViewControllabel?
    
    private var viewModel: ProfileViewModel
    private let refreshControl = UIRefreshControl()
    private var dataSource: UICollectionViewDiffableDataSource<Int, Int>?
    
    init(viewModel: ProfileViewModel, layout: UICollectionViewLayout) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupDataSource()
    }
    
    func update(viewModel: ProfileViewModel?) {
        refreshControl.endRefreshing()
        if let viewModel = viewModel {
            self.viewModel = viewModel
        }
    }
    
    @objc private func didPullToRefresh(_ sender: Any) {
        delegate?.refresh(self)
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        collectionView.register(GeneralInfoCell.self, forCellWithReuseIdentifier: GeneralInfoCell.Constants.reuseIdentifier)
        collectionView.register(RepoCell.self, forCellWithReuseIdentifier: RepoCell.Constants.reuseIdentifier)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.Constants.reuseIdentifier)
        collectionView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) { [weak self]
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            if indexPath.section == 0 {
                let topCell = collectionView.dequeueReusableCell(withReuseIdentifier: GeneralInfoCell.Constants.reuseIdentifier, for: indexPath)
                if let cell = topCell as? GeneralInfoCell {
                    cell.viewModel = GeneralInfoViewModel(user: self?.viewModel.user)
                }
                return topCell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RepoCell.Constants.reuseIdentifier, for: indexPath)
            if let cell = cell as? RepoCell {
                if let nodes = self?.viewModel.nodes[indexPath.section],
                    let node = nodes?[safeIndex: indexPath.row] {
                    cell.viewModel = RepoViewModel(node: node, starCount: 0)
                } else {
                    cell.viewModel = nil
                }
            }
            return cell
        }
        
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.Constants.reuseIdentifier, for: indexPath)
            if let header = header as? SectionHeader {
                header.viewModel = SectionHeaderViewModel(name: self?.viewModel.headerTitles[safeIndex: indexPath.section] ?? "")
            }
            return header
        }

        dataSource?.apply(generateSnapshot(), animatingDifferences: false)
    }
    
    private func generateSnapshot() -> NSDiffableDataSourceSnapshot<Int, Int> {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        // general info section and item
        snapshot.appendSections([0])
        snapshot.appendItems([0])
        // pinned repo section and items
        var sectionIndex = 1
        var identifierIndex = 1
        if (viewModel.pinnedNodes?.count ?? 0) > 0 {
            snapshot.appendSections([sectionIndex])
            sectionIndex += 1
            let maxIdentifier = identifierIndex + (viewModel.pinnedNodes?.count ?? 0)
            snapshot.appendItems(Array(identifierIndex..<maxIdentifier))
            identifierIndex = maxIdentifier + 1
        }
        // top repo section and items
        if (viewModel.topNodes?.count ?? 0) > 0 {
            snapshot.appendSections([sectionIndex])
            sectionIndex += 1
            let maxIdentifier = identifierIndex + (viewModel.topNodes?.count ?? 0)
            snapshot.appendItems(Array(identifierIndex..<maxIdentifier))
            identifierIndex = maxIdentifier + 1
        }
        // starred repo section and items
        if (viewModel.starNodes?.count ?? 0) > 0 {
            snapshot.appendSections([sectionIndex])
            sectionIndex += 1
            let maxIdentifier = identifierIndex + (viewModel.starNodes?.count ?? 0)
            snapshot.appendItems(Array(identifierIndex..<maxIdentifier))
            identifierIndex = maxIdentifier + 1
        }
        return snapshot
    }
    
    private class func applyStandartHeaderAndInsets(_ section: NSCollectionLayoutSection) {
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
    }
    
    class func createLayout(_ pinnedNotesCount: Int) -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            if sectionIndex == 0 || (sectionIndex == 1 && pinnedNotesCount > 0) {
                let height: CGFloat = sectionIndex == 0 ? 200 : 180
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(height)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(height)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                if sectionIndex == 1 {
                    applyStandartHeaderAndInsets(section)
                }
                return section
            }
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(180)))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(180)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            applyStandartHeaderAndInsets(section)
            section.orthogonalScrollingBehavior = .continuous
            return section
        }
    }
}
