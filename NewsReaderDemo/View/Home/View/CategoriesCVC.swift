//
//  CategoriesCVC.swift
//  NewsReaderDemo
//
//  Created by IA on 17/09/24.
//

import UIKit

class CategoriesCVC: UICollectionViewCell {
    
    //
    // MARK: - assign / update data here
    //
    var category: String? {
        didSet { // property observer
            titleLabel.text = category
        }
    }
    
    //
    // MARK: - create UI
    //
    let titleLabel: CustomHeadingTitleLabel = {
        let label = CustomHeadingTitleLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: FontSize.medium, weight: .semibold)
        label.textAlignment = .center
        label.layer.cornerRadius = CornerRadius.small
        label.clipsToBounds = true
        return label
    }()
    
    //
    // MARK: - init
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//
// MARK: - setupUI
//
extension CategoriesCVC {
    
    func setupUI() {
        addSubview(titleLabel)
        
        // MARK: - setup autoLayout
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.viewMarginSmall).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.viewMarginSmall).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.viewMarginSmall).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.viewMarginSmall).isActive = true
    }
}
