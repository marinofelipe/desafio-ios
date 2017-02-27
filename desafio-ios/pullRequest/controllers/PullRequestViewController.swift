//
//  RepositoryDetailViewController.swift
//  desafio-ios
//
//  Created by Felipe Marino on 2/24/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

import UIKit

class PullRequestViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var repositoryName: String!
    var repositoryOwner: String!
    var nameAndLastName: String!
    fileprivate var pullRequests: [PullRequest] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()

        title = self.repositoryName
        
        setupRepositoryDetailTableView()
        fetchPullRequests()
    }
    
    // MARK: - Setup Table View
    func setupRepositoryDetailTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "PullRequestTableViewCell", bundle: nil), forCellReuseIdentifier: "PullRequestCell")
        tableView.separatorStyle = .singleLineEtched
    }
    
    //MARK: - Fetch Pull Requests
    fileprivate func fetchPullRequests() {
        
        PullRequestApi.getPullRequests(owner: self.repositoryOwner, repository: self.repositoryName, success: { pullRequests in
            self.pullRequests = pullRequests
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }) { (statusCode, response, error) in
            Alert.connectionError()
            _ = self.navigationController?.popViewController(animated: true)
        }
    }

}

// MARK: - TableView Delegate
extension PullRequestViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PullRequestCell") as! PullRequestTableViewCell
        
        let height = cell.frame.height
        return height;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
}

// MARK: - TableView DataSource
extension PullRequestViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pullRequests.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView
            .dequeueReusableCell(withIdentifier: "PullRequestCell", for: indexPath) as! PullRequestTableViewCell
        
        cell.selectionStyle = .none
        
        let pullRequest = self.pullRequests[indexPath.row]
        
        let formattedDate = Date().dateFromString(pullRequest.date)
        let stringDate = formattedDate.convertToLongString()
        
        cell.title.text = pullRequest.title
        cell.body.text = pullRequest.body
        cell.username?.text = pullRequest.ownerNick
        cell.date?.text = stringDate
        cell.nameAndLastName?.text = nameAndLastName
        cell.userImage.load(stringUrl: pullRequest.ownerAvatarUrl)
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let pullRequest = self.pullRequests[indexPath.row]
        let url = NSURL(string: pullRequest.url)
        SafariHelper().openUrl(url as! URL, viewController: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view: UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let label: UILabel = UILabel.init()
        label.frame = view.frame
        
        label.textAlignment = .center
        
        var totals = (open: 0, closed: 0)
        totals = PullRequest.totalStates(pullRequests)
        
        label.attributedText = NSMutableAttributedString.stringWithYellowText("\(totals.open) opened ", blackText: "/ \(totals.closed) closed")
        
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(label)
        
        return view
    }
}
