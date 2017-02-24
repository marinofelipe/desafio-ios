//
//  ViewController.swift
//  desafio-ios
//
//  Created by Felipe Marino on 2/24/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var repositoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        
        repositoriesTableView.delegate = self
        repositoriesTableView.dataSource = self
        
        repositoriesTableView.register(UINib.init(nibName: "RepositoryTableViewCell", bundle: nil), forCellReuseIdentifier: "RepositoryCell")

        
        fetchRepositories()
    }
    
//    // MARK: - Manage Transitions/segues to next screen
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        
//        let selectedCell = sender as! UITableViewCell
//        let indexPath = repositoriesTableView.indexPath(for: selectedCell)
//        
//        if indexPath?.section == 0 {
//            return true
//        }
//        else {
//            return false
//        }
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if segue.identifier == "tableViewCellTap" {
//            let selectedCell = sender as! UITableViewCell
//            let indexPath = repositoriesTableView.indexPath(for: selectedCell)
//            let destinationViewController = segue.destination as? DetailViewController
//            
//            destinationViewController?.sourceViewCellText = tableViewDataSource1stSection[(indexPath?.row)!]
//        }
//    }
    
    
    func fetchRepositories() {
        //
    }

}

// MARK: - TableView Delegate
extension ViewController: UITableViewDelegate {
    
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
        return 5.0
    }
}

// MARK: - TableView DataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = repositoriesTableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as! RepositoryTableViewCell
        
        cell.username?.text = "marinofelipe"
        cell.nameAndLastName?.text = "Felipe Marino"
        cell.repositoryName?.text = "iOS Repo"
        cell.repositoryDesc?.text = "this repo contains this ios test asdasda sad asd asd asda sd asd asd asd   "
        cell.forksCount?.text = "399"
        cell.starsCount?.text = "1411"
    
        return cell;
    }
}

// MARK: - ScrollView Delegate
extension ViewController: UIScrollViewDelegate {
    
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

