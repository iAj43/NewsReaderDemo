//
//  ReadFullArticleController.swift
//  NewsReaderDemo
//
//  Created by IA on 17/09/24.
//

import UIKit

class ReadFullArticleController: UIViewController {
    
    // MARK: - setup variables
    var newsArticle: NewsArticle?
    
    //
    // MARK: - create UI
    //
    lazy var customNavigationBar: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Full Article")
        view.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return view
    }()
    
    @objc private func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.backgroundColor = .white
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        return sv
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let thumbImageView: CustomThumbImageView = {
        let imageView = CustomThumbImageView(frame: .zero)
        imageView.layer.cornerRadius = 0
        return imageView
    }()
    
    let newsTitleLabel: CustomHeadingTitleLabel = {
        let label = CustomHeadingTitleLabel()
        return label
    }()
    
    let publishedAtSubTitleLabel: CustomHeadingSubTitleLabel = {
        let label = CustomHeadingSubTitleLabel()
        return label
    }()
    
    let sourceSubTitleLabel: CustomHeadingSubTitleLabel = {
        let label = CustomHeadingSubTitleLabel()
        return label
    }()
    
    let descriptionSubTitleLabel: CustomHeadingSubTitleLabel = {
        let label = CustomHeadingSubTitleLabel()
        label.textColor = .gray
        return label
    }()
    
    //
    // MARK: - viewDidLoad
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    func setupData() {
        //
        if let imageURL = newsArticle?.imageUrl,
           let url = URL(string: imageURL) {
            thumbImageView.loadImage(from: url)
        }
        
        if let title = newsArticle?.title,
           !title.isEmpty {
            newsTitleLabel.text = title
        } else {
            newsTitleLabel.text = nil
        }
        
        if let publishedAt = newsArticle?.publishedAt,
           !publishedAt.isEmpty,
           let customDateString = publishedAt.toCustomDateString() {
            publishedAtSubTitleLabel.text = customDateString
        } else {
            publishedAtSubTitleLabel.text = nil
        }
        
        if let source = newsArticle?.source,
           !source.isEmpty {
            sourceSubTitleLabel.text = "Source: \(source)"
        } else {
            sourceSubTitleLabel.text = nil
        }
        
        if let description = newsArticle?.description,
           !description.isEmpty {
            descriptionSubTitleLabel.text = description
        } else {
            descriptionSubTitleLabel.text = nil
        }
    }
}
//
// MARK: - setupUI
//
extension ReadFullArticleController {
    
    func setupUI() {
        view.backgroundColor = .coolBackground
        view.addSubview(customNavigationBar)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(thumbImageView)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(publishedAtSubTitleLabel)
        contentView.addSubview(sourceSubTitleLabel)
        contentView.addSubview(descriptionSubTitleLabel)
        
        // MARK: - setup auto layout
        customNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        customNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        customNavigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        customNavigationBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        thumbImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        thumbImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        thumbImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        thumbImageView.heightAnchor.constraint(equalToConstant: ViewHeights.thumbImageView).isActive = true
        
        newsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacing.viewMarginSmall).isActive = true
        newsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Spacing.viewMarginSmall).isActive = true
        newsTitleLabel.topAnchor.constraint(equalTo: thumbImageView.bottomAnchor, constant: Spacing.viewMarginExtraSmall).isActive = true
        
        publishedAtSubTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacing.viewMarginSmall).isActive = true
        publishedAtSubTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Spacing.viewMarginSmall).isActive = true
        publishedAtSubTitleLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: Spacing.viewMarginExtraSmall).isActive = true
        
        sourceSubTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacing.viewMarginSmall).isActive = true
        sourceSubTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Spacing.viewMarginSmall).isActive = true
        sourceSubTitleLabel.topAnchor.constraint(equalTo: publishedAtSubTitleLabel.bottomAnchor, constant: Spacing.viewMarginExtraSmall).isActive = true
        
        descriptionSubTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacing.viewMarginSmall).isActive = true
        descriptionSubTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Spacing.viewMarginSmall).isActive = true
        descriptionSubTitleLabel.topAnchor.constraint(equalTo: sourceSubTitleLabel.bottomAnchor, constant: Spacing.viewMarginExtraSmall).isActive = true
        descriptionSubTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Spacing.viewMarginExtraSmall).isActive = true
    }
}
