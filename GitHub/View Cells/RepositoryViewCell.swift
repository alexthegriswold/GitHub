//
//  RepositoryViewCell.swift
//  GitHub
//
//  Created by Alexander Griswold on 8/2/18.
//  Copyright © 2018 com.MobilePic. All rights reserved.
//

import UIKit

class RepositoryViewCell: UICollectionViewCell {
    
    var languageColorCircleWidth: CGFloat = 15
    var containerViewMargin: CGFloat = 10
    
    var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.bold)
        label.textColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var textContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var languageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var languageColorCircle: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 7.5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubview(containerView)
        [titleLabel, textContainerView].forEach { containerView.addSubview($0) }
        [languageColorCircle, languageLabel].forEach { textContainerView.addSubview($0) }
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.backgroundColor = .white
    }
    
    func layoutViews() {
        
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: containerViewMargin).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -containerViewMargin).isActive = true
        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: containerViewMargin).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -containerViewMargin).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.6).isActive = true
        
        textContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        textContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        textContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        textContainerView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.3).isActive = true
        
        languageColorCircle.widthAnchor.constraint(equalToConstant: languageColorCircleWidth).isActive = true
        languageColorCircle.heightAnchor.constraint(equalToConstant: languageColorCircleWidth).isActive = true
        languageColorCircle.leadingAnchor.constraint(equalTo: textContainerView.leadingAnchor).isActive = true
        languageColorCircle.centerYAnchor.constraint(equalTo: textContainerView.centerYAnchor).isActive = true
        
        languageLabel.leadingAnchor.constraint(equalTo: languageColorCircle.trailingAnchor, constant: 5).isActive = true
        languageLabel.trailingAnchor.constraint(equalTo: textContainerView.trailingAnchor).isActive = true
        languageLabel.centerYAnchor.constraint(equalTo: textContainerView.centerYAnchor).isActive = true
        languageLabel.heightAnchor.constraint(equalTo: textContainerView.heightAnchor).isActive = true
        
    }
    
}
