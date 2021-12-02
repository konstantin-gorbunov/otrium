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
        collectionView.register(MockCell.self, forCellWithReuseIdentifier: MockCell.reuseIdentifier)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.Constants.reuseIdentifier)
        collectionView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            if indexPath.section == 0 {
                let topCell = collectionView.dequeueReusableCell(withReuseIdentifier: GeneralInfoCell.Constants.reuseIdentifier, for: indexPath)
                if let cell = topCell as? GeneralInfoCell {
                    cell.viewModel = GeneralInfoViewModel(user: self.viewModel.user)
                }
                return topCell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MockCell.reuseIdentifier, for: indexPath)
            if let cell = cell as? MockCell {
                cell.label.text = "Mock Cell"
                // TODO: config me
            }
            return cell
        }
        
        dataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.Constants.reuseIdentifier, for: indexPath)
            if let header = header as? SectionHeader {
                header.label.text = "Header"
                // TODO: config me
            }
            return header
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0])
        snapshot.appendItems([0])
        snapshot.appendSections([1])
        snapshot.appendItems([1, 2, 3]) // TODO: should be based on viewModel
        
        var identifierOffset = 4
        let itemsPerSection = 10
        for section in 2..<4 {
            snapshot.appendSections([section])
            let maxIdentifier = identifierOffset + itemsPerSection
            snapshot.appendItems(Array(identifierOffset..<maxIdentifier))
            identifierOffset += itemsPerSection
        }
        dataSource?.apply(snapshot, animatingDifferences: false)
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

class SectionHeader: UICollectionReusableView {

    enum Constants {
        static let reuseIdentifier: String = "sectionHeader"
    }
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .orange
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

class MockCell: UICollectionViewCell {
    let label = UILabel()
    static let reuseIdentifier = "MockCell-reuse-identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .random
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 0.7)
    }
}
