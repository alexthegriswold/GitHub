//
//  PullRequestViewCell.swift
//  GitHub
//
//  Created by Alexander Griswold on 8/2/18.
//  Copyright © 2018 com.MobilePic. All rights reserved.
//

import UIKit

class PullRequestViewCell: UICollectionViewCell {
    
    let title: UILabel  = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(title)
        setupView()
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.backgroundColor = .white
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    func layoutViews() {
        title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        title.topAnchor.constraint(equalTo: topAnchor).isActive = true
        title.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
