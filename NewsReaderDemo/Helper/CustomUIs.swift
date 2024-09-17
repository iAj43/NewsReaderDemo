//
//  CustomUIs.swift
//  NewsReaderDemo
//
//  Created by IA on 17/09/24.
//

import UIKit
//
// MARK: - CustomSemiRoundView
//
class CustomSemiRoundView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderColor = UIColor.coolBackground.cgColor
        layer.borderWidth = 0.1
        layer.cornerRadius = CornerRadius.extraSmall
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
// MARK: - CustomThumbImageView
//
class CustomThumbImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .lightGray.withAlphaComponent(0.1)
        contentMode = .scaleAspectFill
        layer.cornerRadius = CornerRadius.extraSmall
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
// MARK: - CustomHeadingTitleLabel
//
class CustomHeadingTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .black
        font = .systemFont(ofSize: FontSize.medium, weight: .medium)
        numberOfLines = 3
        lineBreakMode = .byWordWrapping
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
// MARK: - CustomHeadingSubTitleLabel
//
class CustomHeadingSubTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .darkGray
        font = .systemFont(ofSize: FontSize.small)
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
// MARK: - CustomPlainButton
//
class CustomPlainButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(.systemBlue, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
// MARK: - CustomNavigationBar
//
class CustomNavigationBar: UIView {
    
    let closeButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupUI() {
        backgroundColor = .primaryDark
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle(StringConstants.close, for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = StringConstants.fullArticle
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        
        addSubview(closeButton)
        addSubview(titleLabel)
        
        closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        closeButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
