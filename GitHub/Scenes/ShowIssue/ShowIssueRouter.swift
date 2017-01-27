//
//  ShowIssueRouter.swift
//  GitHub
//
//  Created by CruzDiary on 15/01/2017.
//  Copyright © 2017 cruz. All rights reserved.
//

import UIKit

protocol ShowIssueRouterInput {
    
}

protocol ShowIssueRouterDataSource: class {
    
}

protocol ShowIssueRouterDataDestination: class {
    var id: Int { get set }
}

class ShowIssueRouter: ShowIssueRouterInput {
    
    weak var viewController: ShowIssueViewController!
    weak var dataSource: ShowIssueRouterDataSource!
    weak var dataDestination: ShowIssueRouterDataDestination!
    
    init(viewController: ShowIssueViewController, dataSource: ShowIssueRouterDataSource, dataDestination: ShowIssueRouterDataDestination) {
        self.viewController = viewController
        self.dataSource = dataSource
        self.dataDestination = dataDestination
    }
    
    func passDataToNextScene(_ segue: UIStoryboardSegue) {
        
    }
}
