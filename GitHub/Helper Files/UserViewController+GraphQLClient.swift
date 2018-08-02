//
//  UserViewController+GraphQLClient.swift
//  GitHub
//
//  Created by Alexander Griswold on 8/2/18.
//  Copyright © 2018 com.MobilePic. All rights reserved.
//

import Foundation
import Apollo
import RealmSwift

class UserViewControllerGraphQLClient {
    
    let realm = try! Realm()
    weak var delegate: UserVCGraphQLClientDelegate? = nil
    
    func downloadRepositories() {
        apollo.fetch(query: GetFirstRepositoriesQuery()) { (result, error) in
            guard let repositories = result?.data?.viewer.repositories.edges else { return }
            
            for repository in repositories {
                if let repository = repository {
                    if let id = repository.node?.id, let name = repository.node?.name, let language = repository.node?.primaryLanguage?.name {
                        let stringID = String(id)
                        let newRepository = Repository(id: stringID, name: name, language: language)
                        //delegate
                        self.delegate?.addRepository(repository: newRepository)
                        //self.repositories.append(newRepository)
                        let realmRepository = RealmRepository()
                        realmRepository.id = stringID
                        realmRepository.name = name
                        realmRepository.language = language
                        try! self.realm.write {
                            self.realm.add(realmRepository)
                            
                        }
                        //delegate
                        self.delegate?.updateCurser(curserID: repository.cursor)
                        //self.lastDownloadedCellID = repository.cursor
                        let lastRepositoryID = LastDownloadedRepositoryID()
                        lastRepositoryID.id = repository.cursor
                        try! self.realm.write {
                            self.realm.add(lastRepositoryID)
                        }
                    }
                }
            }
            if let hasNextPage = result?.data?.viewer.repositories.pageInfo.hasNextPage {
                //self.isNextPageAvailable = hasNextPage
                self.delegate?.updatePagination(isNextAvailable: hasNextPage)
            }
            DispatchQueue.main.async {
                self.delegate?.reloadCells()
                //self.collectionView?.reloadData()
            }
        }
    }
    
    func downloadNewRepositories(lastDownloadedCellID: String?) {
        //if !isNextPageAvailable { return }
        guard let lastCellID = lastDownloadedCellID else { return }
        print("LAST:", lastCellID)
        apollo.fetch(query: GetRepositoriesAfterQuery(repositoryID: lastCellID)) { (result, error) in
            
            guard let repositories = result?.data?.viewer.repositories.edges else { return }
            
            for repository in repositories {
                if let repository = repository {
                    if let id = repository.node?.id, let name = repository.node?.name, let language = repository.node?.primaryLanguage?.name {
                        let stringID = String(id)
                        let newRepository = Repository(id: stringID, name: name, language: language)
                        //delegate
                        self.delegate?.addRepository(repository: newRepository)
                        //self.repositories.append(newRepository)
                        let realmRepository = RealmRepository()
                        realmRepository.id = stringID
                        realmRepository.name = name
                        realmRepository.language = language
                        try! self.realm.write {
                            self.realm.add(realmRepository)
                            
                        }
                        //delegate
                        self.delegate?.updateCurser(curserID: repository.cursor)
                        //self.lastDownloadedCellID = repository.cursor
                        let lastRepositoryID = LastDownloadedRepositoryID()
                        lastRepositoryID.id = repository.cursor
                        try! self.realm.write {
                            self.realm.add(lastRepositoryID)
                        }
                    }
                }
            }
            if let hasNextPage = result?.data?.viewer.repositories.pageInfo.hasNextPage {
                //self.isNextPageAvailable = hasNextPage
                self.delegate?.updatePagination(isNextAvailable: hasNextPage)
            }
            DispatchQueue.main.async {
                self.delegate?.reloadCells()
                //self.collectionView?.reloadData()
            }
        }
    }
}

protocol UserVCGraphQLClientDelegate: class {
    func reloadCells()
    func addRepository(repository: Repository)
    func updateCurser(curserID: String)
    func updatePagination(isNextAvailable: Bool)
}
