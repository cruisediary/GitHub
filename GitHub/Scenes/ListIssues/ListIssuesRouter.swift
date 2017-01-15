//
//  ListIssuesRouter.swift
//  GitHub
//
//  Created by CruzDiary on 15/01/2017.
//  Copyright © 2017 cruz. All rights reserved.
//

import UIKit

protocol ListIssuesRouterInput {
    func navigateToShowIssueScene()
}

protocol ListIssuesRouterDataSource: class {
    var id: Int { get }
}

protocol ListIssuesRouterDataDestination: class {}

class ListIssuesRouter: ListIssuesRouterInput {
    weak var viewController: ListIssuesViewController!
    weak var dataSource: ListIssuesRouterDataSource!
    weak var dataDestination: ListIssuesRouterDataDestination!
    
    init(viewController: ListIssuesViewController, dataSource: ListIssuesRouterDataSource, dataDestination: ListIssuesRouterDataDestination) {
        self.viewController = viewController
        self.dataSource = dataSource
        self.dataDestination = dataDestination
    }
    
    func navigateToShowIssueScene() {
        viewController.performSegue(withIdentifier: ShowIssueViewController.segue, sender: nil)
    }
    
    func passDataToNextScene(_ segue: UIStoryboardSegue) {
        if segue.identifier == ShowIssueViewController.segue {
            passDataToShowIssueScene(segue)
        }
    }
    
    func passDataToShowIssueScene(_ segue: UIStoryboardSegue) {
        if let destVC = segue.destination as? ShowIssueViewController {
            destVC.router.dataDestination.id = dataSource.id
        }
    }
}
