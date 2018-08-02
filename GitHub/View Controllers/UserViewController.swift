//
//  ViewController.swift
//  GitHub
//
//  Created by Alexander Griswold on 8/2/18.
//  Copyright © 2018 com.MobilePic. All rights reserved.
//

import UIKit
import Apollo
import RealmSwift

class UserViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UserVCGraphQLClientDelegate {
    
    var repositories = [Repository]()
    var lastDownloadedCellID: String?
    var isNextPageAvailable = true
    
    var graphQLClient = UserViewControllerGraphQLClient()
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        graphQLClient.delegate = self
        
        setupNavBar()
        setupCollectionView()
        initializeData()
    }
    
    func initializeData() {
        let realmRepositories = realm.objects(RealmRepository.self)
        if realmRepositories.count > 0 {
            for repository in realmRepositories {
                repositories.append(Repository(id: repository.id, name: repository.name, language: repository.language))
            }
            let lastCellID = realm.objects(LastDownloadedRepositoryID.self).last
            
            lastDownloadedCellID = lastCellID?.id
            graphQLClient.downloadNewRepositories(lastDownloadedCellID: lastDownloadedCellID)
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
            
        } else {
            graphQLClient.downloadRepositories()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let repository = repositories[indexPath.row]
        let repositoryViewController = RepositoryViewController(collectionViewLayout: UICollectionViewFlowLayout(), repository: repository)
        self.navigationController?.pushViewController(repositoryViewController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == repositories.count && isNextPageAvailable {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Loading Cell", for: indexPath) as! LoadingViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Repository Cell", for: indexPath) as! RepositoryViewCell
            let repository = repositories[indexPath.row]
            cell.titleLabel.text = repository.name
            
            if let language = repository.language {
                cell.languageLabel.text = language
                cell.languageColorCircle.backgroundColor = ColorPickerForLanguage().pickColor(language: language)
            }
            
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return repositories.count + (isNextPageAvailable ? 1 : 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.9, height: 80)
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.isTranslucent = false
        self.title = "Repositories"
    }
    
    func setupCollectionView() {
        collectionView?.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(RepositoryViewCell.self, forCellWithReuseIdentifier: "Repository Cell")
        collectionView?.register(LoadingViewCell.self, forCellWithReuseIdentifier: "Loading Cell")
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == repositories.count && isNextPageAvailable {
            graphQLClient.downloadNewRepositories(lastDownloadedCellID: lastDownloadedCellID)
        }
    }
    
    //MARK: Delegate
    func reloadCells() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    func addRepository(repository: Repository) {
        self.repositories.append(repository)
    }
    
    func updateCurser(curserID: String) {
        self.lastDownloadedCellID = curserID
    }
    
    func updatePagination(isNextAvailable: Bool) {
        self.isNextPageAvailable = isNextAvailable
       
    }
}

