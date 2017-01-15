//
//  User.swift
//  GitHub
//
//  Created by CruzDiary on 15/01/2017.
//  Copyright © 2017 cruz. All rights reserved.
//

import UIKit

import AlamofireObjectMapper
import ObjectMapper

struct User: Mappable {
    var login: String?
    var id: Int?
    var avatarURL: String?
    var url: String?
    var htmlURL: String?
    var followersURL: String?
    var followingURL: String?
    var reposURL: String?

    init() {}

    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        login <- map["login"]
        id <- map["id"]
        avatarURL <- map["avatar_url"]
        url <- map["url"]
        htmlURL <- map["html_url"]
        followersURL <- map["followers_url"]
        followingURL <- map["following_url"]
        reposURL <- map["repos_url"]
    }
}
