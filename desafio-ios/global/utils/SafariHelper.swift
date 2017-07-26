//
//  SafariHelper.swift
//  desafio-ios
//
//  Created by Felipe Lefèvre Marino on 2/27/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

import Foundation
import SafariServices


//TODO: Change to open url on webViewController
class SafariHelper: NSObject, SFSafariViewControllerDelegate {
    
    func openUrl(_ url: URL, viewController: UIViewController) {
        
        if #available(iOS 9.0, *) {
            let safariVC = SFSafariViewController(url: url)
            safariVC.delegate = self
            viewController.present(safariVC, animated: true, completion: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
    }
    
    @available(iOS 9.0, *)
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
