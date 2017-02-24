//
//  StringFormatter.swift
//  desafio-ios
//
//  Created by Felipe Marino on 2/24/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    
    static func stringWithYellowText(_ text: String, blackText: String) -> NSMutableAttributedString{
    
        let yellowPart = NSMutableAttributedString(string: text)
        let blackPart = NSMutableAttributedString(string: blackText)
        
        let yellowRange = NSRange.init(location: 0, length: yellowPart.length)
        yellowPart.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(hexString: "#E68A00"), range: yellowRange)
        
        let blackRange = NSRange.init(location: 0, length: blackPart.length)
        blackPart.addAttribute(NSForegroundColorAttributeName, value: UIColor.black, range: blackRange)
        
        yellowPart.append(blackPart)
        
        return yellowPart
    }
}
