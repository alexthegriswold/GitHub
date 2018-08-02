//
//  RepositoryViewController+GraphQLClient.swift
//  GitHub
//
//  Created by Alexander Griswold on 8/2/18.
//  Copyright © 2018 com.MobilePic. All rights reserved.
//

import Foundation
import RealmSwift
import Apollo

class RepositoryViewControllerGraphQLClient {
    
    let realm = try! Realm()
    
    weak var delegate: RepositoryVCGraphQLClientDelegate? = nil
    
    func downloadPullRequests(repositoryName: String) {
        apollo.fetch(query: GetPullRequestsQuery(repositoryName: repositoryName)) { (result, error) in
            guard let pullRequests = result?.data?.viewer.repository?.pullRequests.edges else { return }
            for pullRequest in pullRequests {
                if let pullRequest = pullRequest?.node {
                    if pullRequest.closed == true { continue }
                    
                    guard let author = pullRequest.author?.login else { continue }
                   
                    let newPullRequest = PullRequest(repositoryName: repositoryName, title: pullRequest.title, number: pullRequest.number, author: author, date: pullRequest.createdAt)
                    self.delegate?.addPullRequest(pullRequest: newPullRequest)
                    
                    let realmPullRequest = RealmPullRequest()
                    realmPullRequest.repositoryName = repositoryName
                    realmPullRequest.title = pullRequest.title
                    realmPullRequest.number = pullRequest.number
                    realmPullRequest.author = author
                    realmPullRequest.date = pullRequest.createdAt
                    try! self.realm.write {
                        self.realm.add(realmPullRequest)
                        
                    }
                }
            }
            DispatchQueue.main.async {
                self.delegate?.reloadCells()
            }
        }
    }
}

protocol RepositoryVCGraphQLClientDelegate: class {
    func reloadCells()
    func addPullRequest(pullRequest: PullRequest)
    
}
