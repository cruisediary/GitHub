//
//  ListIssuesPresenter.swift
//  GitHub
//
//  Created by CruzDiary on 27/01/2017.
//  Copyright © 2017 cruz. All rights reserved.
//

import UIKit

extension ListIssuesPresenter: ListIssuesViewControllerOutput, ListIssuesRouterDataSource, ListIssuesRouterDataDestination {
}

extension ListIssuesViewController: ListIssuesPresenterOutput {
}

final class ListIssuesConfigurator {
    // MARK: Object lifecycle
    
    class var sharedInstance: ListIssuesConfigurator {
        struct Static {
            static let instance: ListIssuesConfigurator = ListIssuesConfigurator()
        }
        
        return Static.instance
    }
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(_ viewController: ListIssuesViewController) {
        
        let presenter = ListIssuesPresenter()
        presenter.output = viewController
        
        let router = ListIssuesRouter(viewController: viewController, dataSource: presenter, dataDestination: presenter)
        
        viewController.output = presenter
        viewController.router = router
    }
}
