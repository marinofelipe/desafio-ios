//
//  UserDefaultsManager.swift
//  desafio-ios
//
//  Created by Felipe Lefèvre Marino on 7/24/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

import Foundation

public class UserDefaultsManager {
    
    static let standard = UserDefaults.standard
    static let lastSelectedLanguage = "lastSelectedLanguage"
    
    static func setNewLastSelected(language: String) {
        standard.set(language, forKey: lastSelectedLanguage)
    }
    
    static func getNewLastSelectedLanguage() -> String {
        let language = standard.object(forKey: lastSelectedLanguage) as! String
        return language
    }
    
    static func configureLastSelectedLanguage() {
        if let _ = standard.object(forKey: lastSelectedLanguage) as? String {
            return
        }
        else {
            standard.set("Java", forKey: lastSelectedLanguage)
        }
    }
}
