//
//  UIBarButtonItem.swift
//  desafio-ios
//
//  Created by Felipe Lefèvre Marino on 2/24/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    
    func plain() {
        title = ""
        style = .plain
        target = nil
        action = nil
    }
}
