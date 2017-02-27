//
//  Alert.swift
//  desafio-ios
//
//  Created by Felipe Lefèvre Marino on 2/26/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

import Foundation
import UIKit
import SwiftyDrop

class Alert {
    
    class func connectionError() {
        Drop.down(NSLocalizedString("generalErrorMessageDefault", comment: ""), state: .error, duration: 3.0, action: nil)
    }
    
}
