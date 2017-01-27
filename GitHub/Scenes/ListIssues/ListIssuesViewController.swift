//
//  ListIssuesViewController.swift
//  GitHub
//
//  Created by CruzDiary on 15/01/2017.
//  Copyright © 2017 cruz. All rights reserved.
//

import UIKit

import RxSwift

protocol ListIssuesViewControllerInput {
    func displayIssues(_ viewModel: ListIssues.FetchIssues.ViewModel)
}

protocol ListIssuesViewControllerOutput {
    func fetchIssues()
}

class ListIssuesViewController: UIViewController, ListIssuesViewControllerInput {
    var router: ListIssuesRouter!
    var output: ListIssuesViewControllerOutput!
    
    var id: Int = -1 {
        didSet {
            guard id != -1 else { return }
            router.navigateToShowIssueScene()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    enum Section {
        static let number = 1
    }
    
    enum State {
        case fetching
        case fetched
        case networkError
    }
    
    var state: State = .fetching {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var viewModel = ListIssues.FetchIssues.ViewModel(issues: [])

    override func awakeFromNib() {
        super.awakeFromNib()
        ListIssuesConfigurator.sharedInstance.configure(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerUINibs()
        
        state = .fetching
        // Do any additional setup after loading the view.
    }
    
    func registerUINibs() {
        collectionView.register(UINib(nibName: IndicatorCell.nibName, bundle: nil), forCellWithReuseIdentifier: IndicatorCell.reuseIdentifier)
        collectionView.register(UINib(nibName: ListIssueCell.nibName, bundle: nil), forCellWithReuseIdentifier: ListIssueCell.reuseIdentifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Issues"
        switch state {
        case .fetching, .networkError: output.fetchIssues()
        case .fetched: break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func displayIssues(_ viewModel: ListIssues.FetchIssues.ViewModel) {
        DispatchQueue.main.async {
            self.viewModel = viewModel
            self.state = .fetched
        }
    }
}

extension ListIssuesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = viewModel.issue(at: indexPath)?.id else { return }
        self.id = id
    }
}

extension ListIssuesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch state {
        case .fetching:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IndicatorCell.reuseIdentifier, for: indexPath) as! IndicatorCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListIssueCell.reuseIdentifier, for: indexPath) as! ListIssueCell
            if let issue = viewModel.issue(at: indexPath) {
                cell.configure(issue: issue)
            }
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.number
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch state {
        case .fetching, .networkError: return 1
        case .fetched: return viewModel.numberOfItem
        }
    }
}

extension ListIssuesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch state {
        case .fetching, .networkError: return collectionView.bounds.size
        case .fetched: return CGSize(width: collectionView.width, height: ListIssueCell.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

extension UIView {
    var width: CGFloat {
        return bounds.width
    }
}
