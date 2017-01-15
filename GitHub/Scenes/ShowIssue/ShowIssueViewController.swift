//
//  ShowIssueViewController.swift
//  GitHub
//
//  Created by CruzDiary on 15/01/2017.
//  Copyright © 2017 cruz. All rights reserved.
//

import UIKit

extension ShowIssueViewController: ShowIssueRouterDataSource {}

extension ShowIssueViewController: ShowIssueRouterDataDestination {}

class ShowIssueViewController: UIViewController {
    static let segue = "ShowIssueScene"
    var router: ShowIssueRouter!
    var id: Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        router = ShowIssueRouter(viewController: self, dataSource: self, dataDestination: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "\(id)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
