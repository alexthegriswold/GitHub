//
//  PullRequestViewController.swift
//  GitHub
//
//  Created by Alexander Griswold on 8/2/18.
//  Copyright © 2018 com.MobilePic. All rights reserved.
//

import UIKit


class PullRequestViewController: UIViewController {
    
    var pullRequest: PullRequest
    
    init(pullRequest: PullRequest) {
        self.pullRequest = pullRequest
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let pullRequestView = PullRequestView(frame: .zero)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(pullRequestView)
        setupView()
        layoutView()
    }
    
    func setupView() {
        title = "Pull Request"
        view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        pullRequestView.frame = view.frame
        
        self.pullRequestView.title.text = pullRequest.title
        var createdAt = pullRequest.date
        let date = String(createdAt[createdAt.startIndex...createdAt.index(createdAt.startIndex, offsetBy: 9)])
        self.pullRequestView.date.text = date
        self.pullRequestView.author.text = pullRequest.author
    }
    
    func layoutView() {
        pullRequestView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        pullRequestView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        pullRequestView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        pullRequestView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
    
}
