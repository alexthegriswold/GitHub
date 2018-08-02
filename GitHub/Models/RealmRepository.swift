//
//  RealmRepository.swift
//  GitHub
//
//  Created by Alexander Griswold on 8/2/18.
//  Copyright © 2018 com.MobilePic. All rights reserved.
//

import Foundation
import RealmSwift

class RealmRepository: Object  {
    
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var language: String? = nil
    let value = List<RealmPullRequest>()
    
}
