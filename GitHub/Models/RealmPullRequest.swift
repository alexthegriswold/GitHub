//
//  RealmPullRequest.swift
//  GitHub
//
//  Created by Alexander Griswold on 8/2/18.
//  Copyright © 2018 com.MobilePic. All rights reserved.
//

import Foundation
import RealmSwift

class RealmPullRequest: Object {
    @objc dynamic var repositoryName = ""
    @objc dynamic var title = ""
    @objc dynamic var number = 0
    @objc dynamic var author = ""
    @objc dynamic var date = ""
}

