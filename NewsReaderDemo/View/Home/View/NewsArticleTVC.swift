//
//  NewsArticleTVC.swift
//  NewsReaderDemo
//
//  Created by IA on 18/09/24.
//

import UIKit

class NewsArticleTVC: UITableViewCell {
    
    //
    // MARK: - assign / update data here
    //
    var setterObj: NewsArticle? {
        didSet { // property observer
            //
            if let imageURL = setterObj?.imageUrl,
               let url = URL(string: imageURL) {
                thumbImageView.loadImage(from: url)
            }
            
            if let title = setterObj?.title,
               !title.isEmpty {
                newsTitleLabel.text = title
            } else {
                newsTitleLabel.text = nil
            }
            
            if let publishedAt = setterObj?.publishedAt,
               !publishedAt.isEmpty,
               let customDateString = publishedAt.toCustomDateString() {
                publishedAtSubTitleLabel.text = customDateString
            } else {
                publishedAtSubTitleLabel.text = nil
            }
        }
    }
    
    //
    // MARK: - create UI
    //
    let mainView: CustomSemiRoundView = {
        let view = CustomSemiRoundView()
        view.backgroundColor = .white
        return view
    }()
    
    let thumbImageView: CustomThumbImageView = {
        let imageView = CustomThumbImageView(frame: .zero)
        return imageView
    }()
    
    let newsTitleLabel: CustomHeadingTitleLabel = {
        let label = CustomHeadingTitleLabel()
        return label
    }()
    
    lazy var menuButton: CustomPlainButton = {
        let button = CustomPlainButton()
        button.setImage(UIImage(named: ImageConstants.iconMenuVertical), for: .normal)
        return button
    }()
    
    let publishedAtSubTitleLabel: CustomHeadingSubTitleLabel = {
        let label = CustomHeadingSubTitleLabel()
        return label
    }()
    
    //
    // MARK: - init
    //
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//
// MARK: - setupUI
//
extension NewsArticleTVC {
    
    func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(mainView)
        mainView.addSubview(thumbImageView)
        mainView.addSubview(newsTitleLabel)
        mainView.addSubview(menuButton)
        mainView.addSubview(publishedAtSubTitleLabel)
        
        // MARK: - setup autoLayout
        mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacing.viewMarginMedium).isActive = true
        mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Spacing.viewMarginMedium).isActive = true
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Spacing.viewMarginSmall).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Spacing.viewMarginSmall).isActive = true
        
        thumbImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        thumbImageView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        thumbImageView.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        thumbImageView.heightAnchor.constraint(equalToConstant: ViewHeights.thumbImageView).isActive = true
        
        newsTitleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: Spacing.viewMarginSmall).isActive = true
        newsTitleLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -Spacing.viewMarginSmall).isActive = true
        newsTitleLabel.topAnchor.constraint(equalTo: thumbImageView.bottomAnchor, constant: Spacing.viewMarginExtraSmall).isActive = true
        
        menuButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        menuButton.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: Spacing.viewMarginExtraSmall).isActive = true
        menuButton.widthAnchor.constraint(equalToConstant: RegularButtonSize.width).isActive = true
        menuButton.heightAnchor.constraint(equalToConstant: RegularButtonSize.height).isActive = true
        
        publishedAtSubTitleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: Spacing.viewMarginSmall).isActive = true
        publishedAtSubTitleLabel.trailingAnchor.constraint(equalTo: menuButton.leadingAnchor, constant: -Spacing.viewMarginSmall).isActive = true
        publishedAtSubTitleLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: Spacing.viewMarginExtraSmall).isActive = true
        publishedAtSubTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: RegularButtonSize.height).isActive = true
        publishedAtSubTitleLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -Spacing.viewMarginExtraSmall).isActive = true
    }
}
