//
//  WebViewController.swift
//  desafio-ios
//
//  Created by Felipe Lefèvre Marino on 7/26/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    public var url: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadRequest() {
        if let _url = url {
            webView.loadRequest(URLRequest(url: _url))
        }
    }
}
