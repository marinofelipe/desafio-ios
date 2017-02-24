//
//  RepositoryDetailViewController.swift
//  desafio-ios
//
//  Created by Felipe Marino on 2/24/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

import UIKit

class RepositoryDetailViewController: UIViewController {

    @IBOutlet weak var repositoryDetailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Nome do Repositório"
        
        setupRepositoryDetailTableView()
    }
    
    // MARK: - Setup Table View
    func setupRepositoryDetailTableView() {
        repositoryDetailTableView.delegate = self
        repositoryDetailTableView.dataSource = self
        repositoryDetailTableView.register(UINib.init(nibName: "RepositoryDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "RepositoryDetailCell")
        repositoryDetailTableView.separatorStyle = .singleLineEtched
    }

}

// MARK: - TableView Delegate
extension RepositoryDetailViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cell = repositoryDetailTableView.dequeueReusableCell(withIdentifier: "RepositoryDetailCell") as! RepositoryDetailTableViewCell
        
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
extension RepositoryDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = repositoryDetailTableView.dequeueReusableCell(withIdentifier: "RepositoryDetailCell", for: indexPath) as! RepositoryDetailTableViewCell
        
        cell.selectionStyle = .none
        
        cell.username?.text = "marinofelipe"
        cell.nameAndLastName?.text = "Felipe Marino"
        cell.title?.text = "Pull request #XXXYXT"
        cell.body?.text = "Pull request body and content lorem ipsum lorem lorem atim lorem ate ipsum"
        cell.date?.text = "14/11/2016"
          
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("\nrow selected: \(indexPath.row); open commit url")
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "16 opened/800 closed"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view: UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let label: UILabel = UILabel.init()
        label.frame = view.frame
        
        label.textAlignment = .center
        
        label.attributedText = NSMutableAttributedString.stringWithYellowText("16 opened ", blackText: "/ 800 closed")
        
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(label)
        
        return view
    }
}
