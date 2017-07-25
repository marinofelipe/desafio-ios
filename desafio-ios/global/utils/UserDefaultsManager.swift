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
    static let keyLastSelectedLang = "lastSelectedLanguage"
    static let keyLastSearchedLang = "lastSearchedLanguage"
    
    static func setLastSelected(language: String) {
        standard.set(language, forKey: keyLastSelectedLang)
    }
    
    static func getLastSelectedLanguage() -> String {
        let language = standard.object(forKey: keyLastSelectedLang) as! String
        return language
    }
    
    static func configureLastSelectedLanguage() {
        if let _ = standard.object(forKey: keyLastSelectedLang) as? String {
            return
        }
        standard.set("Java", forKey: keyLastSelectedLang)
    }
    
    static func setLastSearched(language: String) {
        standard.set(language, forKey: keyLastSearchedLang)
    }
    
    static func getLastSearchedLanguage() -> String {
        if let language = standard.object(forKey: keyLastSearchedLang) as? String {
           return language
        }
        return getLastSelectedLanguage()
    }
}
