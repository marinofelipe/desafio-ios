//
//  Bundle.swift
//  desafio-ios
//
//  Created by Felipe Lefèvre Marino on 2/26/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

import Foundation


extension Bundle {
    
    var apiBaseUrl: String {
        return self.object(forInfoDictionaryKey: "apiBaseUrl") as! String
    }
    
}
