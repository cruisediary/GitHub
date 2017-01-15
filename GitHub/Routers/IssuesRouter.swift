//
//  IssuesRouter.swift
//  GitHub
//
//  Created by CruzDiary on 15/01/2017.
//  Copyright © 2017 cruz. All rights reserved.
//

import UIKit

import Alamofire

enum IssuesRouter: URLRequestConvertible {
    static let baseURL = "https://api.github.com/repos/"
    case fetchIssue(request: FetchIssue.Request)
    case fetchIssues(request: FetchIssues.Request)
}

extension IssuesRouter {
    func asURLRequest() throws -> URLRequest {
        let result: (path: String, method: Alamofire.HTTPMethod, parameters: [String: AnyObject]) = {
            switch self {
            case .fetchIssues(let request):
                return ("\(request.userName)/\(request.repo)/issues", .get, [String: AnyObject]())
            }
        }()
        
        let url = try IssuesRouter.baseURL.asURL()
        var request = URLRequest(url: url.appendingPathComponent(result.path))
        request.httpMethod = result.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return try URLEncoding.default.encode(request, with: result.parameters)
    }
}
