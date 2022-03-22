//
//  CollectionViewController.swift
//  TableAndCollectionView
//
//  Created by Denis on 22.03.2022.
//

import Foundation
import UIKit

enum CollectionViewSection {
    case main
}
struct ViewModel: Hashable {
    let id: UUID
    let image: UIImage
    
    init(image: UIImage) {
        id = UUID()
        self.image = image
    }
}

final class CollectionViewController: UICollectionViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<CollectionViewSection, ViewModel>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<CollectionViewSection, ViewModel>
    
    private lazy var dataSource = createDataSource()
    
    let viewModels = (1...13).map{ ViewModel(image: UIImage(named: String($0))!) }
    
    init() {
        super.init(collectionViewLayout: CollectionViewController.collectionViewLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        applySnapshot()
    }
    
    private func setupCollectionView() {
        let nib = UINib(nibName: ImageCollectionViewCell.reuseIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
    }
    
    private func createDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, viewModel in
            guard let self = self else { return nil }
            
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageCollectionViewCell
            
            cell?.configure(image: viewModel.image)
            
            return cell
        }
        
        return dataSource
    }
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
    
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModels)
    
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    private static func collectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
    
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 10)
    
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(1/3))
    
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 3)
    
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension CollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell
        cell?.isChosen.toggle()
    }
}



