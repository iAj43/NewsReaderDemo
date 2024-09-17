//
//  CategoriesHeaderView.swift
//  NewsReaderDemo
//
//  Created by IA on 17/09/24.
//

import UIKit

class CategoriesHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - setup variables
    weak var homeControllerDelegate: HomeController?
    private let categoriesCVCellID: String = "categoriesCVCellID"
    
    //
    // MARK: - create UI
    //
    lazy var categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.register(CategoriesCVC.self, forCellWithReuseIdentifier: self.categoriesCVCellID)
        return cv
    }()
    
    //
    // MARK: - init
    //
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//
// MARK: - UICollectionViewDataSource methods
//
extension CategoriesHeaderView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoriesCVCellID, for: indexPath) as? CategoriesCVC else { return UICollectionViewCell() }
        cell.category = categoriesArray[indexPath.item]
        if indexPath.item == selectedIndex {
            cell.titleLabel.backgroundColor = .primaryDark
            cell.titleLabel.textColor = .white
        } else {
            cell.titleLabel.backgroundColor = .clear
            cell.titleLabel.textColor = .gray
        }
        return cell
    }
}
//
// MARK: - UICollectionViewDelegate methods
//
extension CategoriesHeaderView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        categoriesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        categoriesCollectionView.reloadData()
        newsCategory = categoriesArray[indexPath.item].lowercased()
        homeControllerDelegate?.initializeViewModel()
        homeControllerDelegate?.setupBindings()
        homeControllerDelegate?.fetchNewsData()
    }
}
//
// MARK: - UICollectionViewDelegateFlowLayout methods
//
extension CategoriesHeaderView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellPadding = Spacing.viewMarginSmall + Spacing.viewMarginSmall
        let maxHeight: CGFloat = 50
        let width = categoriesArray[indexPath.item].width(withFont: .systemFont(ofSize: FontSize.medium), maxHeight: maxHeight) + cellPadding
        return CGSize(width: width, height: maxHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
//
// MARK: - setupUI
//
extension CategoriesHeaderView {
    
    func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(categoriesCollectionView)
        
        // MARK: - setup autoLayout
        categoriesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        categoriesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        categoriesCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        categoriesCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
