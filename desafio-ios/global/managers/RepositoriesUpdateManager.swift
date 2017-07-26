//
//  RepositoriesUpdateManager.swift
//  desafio-ios
//
//  Created by Felipe Marino on 26/07/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

import Foundation
import UIKit

public typealias FetchingWasSuccessful = ((Bool?) -> Void)?

public class RepositoriesUpdateManager {
    static let shared = RepositoriesUpdateManager()
    
    public func update(withLanguage language: String, completion: FetchingWasSuccessful) {
        DispatchQueue.global().async {
            UserDefaultsManager.setLastSelected(language: language)
            let navController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
            if let currentController = navController.topViewController as? RepositoriesViewController {
                currentController.fetchRepositories(withCompletion: { (wasSuccessful) in
                    completion!(wasSuccessful)
                })
            }
        }
    }
}
