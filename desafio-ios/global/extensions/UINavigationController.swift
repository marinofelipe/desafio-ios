//
//  UINavigationController.swift
//  desafio-ios
//
//  Created by Felipe Lefèvre Marino on 2/24/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    override open func awakeFromNib() {
        customizeDefault()
    }
    
    private func customizeDefault() {
        self.navigationBar.barTintColor = UIColor.black
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 20.0), NSForegroundColorAttributeName: UIColor.white]
    }
}
