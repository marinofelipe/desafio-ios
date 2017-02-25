//
//  ViewController.swift
//  desafio-ios
//
//  Created by Felipe Marino on 2/24/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

import UIKit

class RepositoriesViewController: UIViewController {

    @IBOutlet weak var repositoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem?.plain()

        setupRepositoriesTableView()
        fetchRepositories()
    }
    
    // MARK: - Setup Table View
    func setupRepositoriesTableView() {
        repositoriesTableView.delegate = self
        repositoriesTableView.dataSource = self
        repositoriesTableView.register(UINib.init(nibName: "RepositoryTableViewCell", bundle: nil), forCellReuseIdentifier: "RepositoryCell")
        repositoriesTableView.separatorStyle = .singleLineEtched
    }
    
    // MARK: - Manage Transitions/segues to next screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        if segue.identifier == "RepositoryCellTap" {
//            let selectedCell = sender as! UITableViewCell
//            let indexPath = repositoriesTableView.indexPath(for: selectedCell)
//        }
    }
    
    
    func fetchRepositories() {
        //
    }

}

// MARK: - TableView Delegate
extension RepositoriesViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cell = repositoriesTableView.dequeueReusableCell(withIdentifier: "RepositoryCell") as! RepositoryTableViewCell
        
        let height = cell.frame.height
        return height;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
}

// MARK: - TableView DataSource
extension RepositoriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = repositoriesTableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as! RepositoryTableViewCell
        
        cell.selectionStyle = .none
        
        cell.username?.text = "marinofelipe"
        cell.nameAndLastName?.text = "Felipe Marino"
        cell.repositoryName?.text = "iOS Repo"
        cell.repositoryDesc?.text = "this repo contains this ios test asdasda sad asd asd asda sd asd asd asd   "
        cell.forksCount?.text = "399"
        cell.starsCount?.text = "1411"
    
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("row selected: \(indexPath.row)")
        
        self.performSegue(withIdentifier: "RepositoryCellTap", sender:tableView.cellForRow(at: indexPath))
    }
}

// MARK: - ScrollView Delegate
extension RepositoriesViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // calculates where the user is in the y-axis
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            
//            indexOfPageToRequest += 1
            
//            api(indexOfPageToRequest)
            
            // tell the table view to reload with the new data
            repositoriesTableView.reloadData()
        }
    }
}

