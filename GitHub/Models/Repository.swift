//
//  Repository.swift
//  GitHub
//
//  Created by Alexander Griswold on 8/2/18.
//  Copyright © 2018 com.MobilePic. All rights reserved.
//

import Foundation

class Repository {
    let id: String
    let name: String
    let language: String?
    var pullRequests = [PullRequest]()
    
    init(id: String, name: String, language: String?) {
        self.id = id
        self.name = name
        self.language = language
    }
}
