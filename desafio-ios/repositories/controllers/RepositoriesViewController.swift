//
//  ViewController.swift
//  desafio-ios
//
//  Created by Felipe Marino on 2/24/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

import UIKit

class RepositoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    fileprivate var repositories:[Repository] = []
    fileprivate var page = 0
    fileprivate var isLoading = true
    fileprivate var hasConnectionError = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        
        navigationItem.backBarButtonItem?.plain()

        setupRepositoriesTableView()
        fetchRepositories()
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetchRepositories), name: NSNotification.Name(rawValue: "reloadRepositories"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchRepositories()
    }
    
    // MARK: - Setup Table View
    fileprivate func setupRepositoriesTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "RepositoryTableViewCell", bundle: nil), forCellReuseIdentifier: "RepositoryCell")
        tableView.separatorStyle = .singleLineEtched
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // MARK: - Fetch Repositories
    @objc fileprivate func fetchRepositories() {
        //FIXME: Add better activity indicator to show that the content is beign reloaded
        self.isLoading = true
        
        let language = UserDefaultsManager.getLastSelectedLanguage()
        let lastSearched = UserDefaultsManager.getLastSearchedLanguage()
        
        if language != lastSearched {
            repositories.removeAll()
        }
        
        RepositoryHTTPClient.getRepositories(language: language, page: self.page + 1, success: { repositories in
            
            guard repositories.count > 0 else {
                self.isLoading = false
                self.hasConnectionError = false
                self.activityIndicator.stopAnimating()
                return
            }
            
            UserDefaultsManager.setLastSearched(language: language)
            
            self.repositories += repositories
            self.tableView.reloadData()
            self.page += 1
            self.hasConnectionError = false
            
        }) { (statusCode, response, error) in
            if statusCode == HTTPClient.statusCodes.disconnected.rawValue && !self.hasConnectionError {
                Alert.connectionError()
                self.hasConnectionError = true
            }
        }
        
        self.isLoading = false
        self.activityIndicator.stopAnimating()
    }
    
    // MARK: - Manage Transitions/segues to next screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UITableViewCell
        let indexPath = self.tableView.indexPath(for: cell)
        
        let pullRequestVC = segue.destination as! PullRequestViewController
        
        let repositorySelected = self.repositories[(indexPath?.row)!]
        
        pullRequestVC.repositoryName = repositorySelected.name
        pullRequestVC.repositoryOwner = repositorySelected.ownerNick
        pullRequestVC.nameAndLastName = repositorySelected.ownerFullName
        
        tableView.deselectRow(at: indexPath!, animated: true)
    }
}

// MARK: - TableView Delegate
extension RepositoriesViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }
}

// MARK: - TableView DataSource
extension RepositoriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repositories.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as! RepositoryTableViewCell
        
        cell.selectionStyle = .none
        
        let repository = repositories[indexPath.row]
        
        cell.username?.text = repository.ownerNick
        cell.nameAndLastName?.text = repository.ownerNick
        cell.repositoryName?.text = repository.name
        cell.repositoryDesc?.text = repository.description
        cell.forksCount?.text = String(describing: repository.forks)
        cell.starsCount?.text = String(describing: repository.favorites)
        cell.userImage.load(stringUrl: repository.ownerAvatarUrl)
        cell.nameAndLastName?.text = repository.ownerFullName
    
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("row selected: \(indexPath.row)")
        
        self.performSegue(withIdentifier: "RepositoryCellTap", sender:tableView.cellForRow(at: indexPath))
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row >= (self.repositories.count - 10) && !self.isLoading {
            self.fetchRepositories()
        }
    }
}

// MARK: - ScrollView Delegate
extension RepositoriesViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // calculates where the user is in the y-axis
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            fetchRepositories()
        }
    }
}
