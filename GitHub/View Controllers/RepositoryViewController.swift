//
//  RepositoryViewController.swift
//  GitHub
//
//  Created by Alexander Griswold on 8/2/18.
//  Copyright © 2018 com.MobilePic. All rights reserved.
//

import UIKit
import RealmSwift

class RepositoryViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, RepositoryVCGraphQLClientDelegate {
    
    var repository: Repository
    var pullRequests = [PullRequest]()
    
    var graphQLClient = RepositoryViewControllerGraphQLClient()
    
    let realm = try! Realm()
    
    init(collectionViewLayout layout: UICollectionViewLayout, repository: Repository) {
        self.repository = repository
        
        super.init(collectionViewLayout: layout)
        self.title = repository.name
        graphQLClient.delegate = self
        initializeData()
        //graphQLClient.downloadPullRequests(repositoryName: repository.name)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupNavBar()
    }
    
    func initializeData() {
        let realmPullRequests = realm.objects(RealmPullRequest.self).filter("repositoryName = %@", repository.name)
        if realmPullRequests.count > 0 {
            for pullRequest in realmPullRequests {
                pullRequests.append(PullRequest(repositoryName: pullRequest.repositoryName, title: pullRequest.title, number: pullRequest.number, author: pullRequest.author, date: pullRequest.author))
            }
            
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
            
        } else {
            graphQLClient.downloadPullRequests(repositoryName: repository.name)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (pullRequests.count == 0) ? 2 : pullRequests.count + 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Header Cell", for: indexPath)
            return cell
        } else {
            if pullRequests.count == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Loading Cell", for: indexPath) as! LoadingViewCell
                return cell
            } 
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Pull Request Cell", for: indexPath) as! PullRequestViewCell
            let pullRequest = pullRequests[indexPath.row - 1]
            cell.title.text = pullRequest.title
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pullRequest = pullRequests[indexPath.row - 1]
        navigationController?.pushViewController(PullRequestViewController(pullRequest: pullRequest), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0 {
            return CGSize(width: self.view.frame.width * 0.9, height: 40)
        } else {
            return CGSize(width: self.view.frame.width * 0.9, height: 45)
        }
    }
    
    func setupCollectionView() {
        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        collectionView?.register(PullRequestViewCell.self, forCellWithReuseIdentifier: "Pull Request Cell")
        collectionView?.register(HeaderViewCell.self, forCellWithReuseIdentifier: "Header Cell")
        collectionView?.register(LoadingViewCell.self, forCellWithReuseIdentifier: "Loading Cell")
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    //MARK: Delegate
    func reloadCells() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    func addPullRequest(pullRequest: PullRequest) {
        pullRequests.append(pullRequest)
    }

}
