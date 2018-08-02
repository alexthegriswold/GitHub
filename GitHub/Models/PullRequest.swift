//
//  PullRequest.swift
//  GitHub
//
//  Created by Alexander Griswold on 8/2/18.
//  Copyright © 2018 com.MobilePic. All rights reserved.
//

import Foundation

class PullRequest {
    let repositoryName: String
    let title: String
    let number: Int
    let author: String
    let date: String
    
    
    init(repositoryName: String, title: String, number: Int, author: String, date: String) {
        self.repositoryName = repositoryName
        self.title = title
        self.number = number
        self.author = author
        self.date = date
    }
}
