//
//  Issue.swift
//  GitHub
//
//  Created by CruzDiary on 15/01/2017.
//  Copyright © 2017 cruz. All rights reserved.
//

import UIKit

import AlamofireObjectMapper
import ObjectMapper

struct Issue: Mappable {
    var id: Int?
    var url: String?
    var number: Int?
    var title: String?
    var state: String?
    var user: User?
    var createdAt: Date?
    var updatedAt: Date?
    var body: String?

    init(){}
    
    init?(map: Map) {}

    mutating func mapping(map: Map) {
        id <- map["id"]
        url <- map["url"]
        number <- map["number"]
        title <- map["title"]
        state <- map["state"]
        user <- map["user"]
        createdAt <- (map["created_at"], ISO8601DateTransform())
        updatedAt <- (map["updated_at"], ISO8601DateTransform())
        body <- map["body"]
    }
}

extension Issue {
    var openedInfo: String? {
        guard let userName = user?.login, let createdAt = createdAt else { return nil }
        return "Opened by \(userName) about \(createdAt.relativeTime)"
    }
}
