//
//  ListIssuesModel.swift
//  GitHub
//
//  Created by CruzDiary on 15/01/2017.
//  Copyright © 2017 cruz. All rights reserved.
//

import UIKit

struct ListIssues {
    struct Request {
        var userName: String
        var repo: String
    }
    
    struct FetchIssues {
        struct ViewModel {
            var issues: [Issue]
            var numberOfItem: Int { return issues.count }
            func issue(at indexPath: IndexPath) -> Issue? {
                return issues[safe: indexPath.item]
            }
        }
    }
}
