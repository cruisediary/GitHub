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
    var url: String?
    var number: Int?
    var title: String?
    var state: String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        url <- map["url"]
        number <- map["number"]
        title <- map["title"]
        state <- map["state"]
    }
}
