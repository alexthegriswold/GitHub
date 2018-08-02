//
//  PullRequestView.swift
//  GitHub
//
//  Created by Alexander Griswold on 8/2/18.
//  Copyright © 2018 com.MobilePic. All rights reserved.
//

import UIKit

class PullRequestView: UIView {
    
    let titleToTextMargin: CGFloat = 5
    let sectionMargin: CGFloat = 10
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "Author"
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var author: UILabel = {
        let label = UILabel()

        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date Posted"
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var date: UILabel = {
        let label = UILabel()

        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupView()
        [titleLabel, title, authorLabel, author, dateLabel, date].forEach { self.addSubview($0) }
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    func layoutViews() {
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: sectionMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        title.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: titleToTextMargin).isActive = true
        title.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        
        authorLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: sectionMargin).isActive = true
        authorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        
        author.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: titleToTextMargin).isActive = true
        author.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: author.bottomAnchor, constant: sectionMargin).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        
        date.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: titleToTextMargin).isActive = true
        date.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        
    }
}
