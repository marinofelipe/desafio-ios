//
//  CustomHamburguerItem.swift
//  desafio-ios
//
//  Created by Felipe Lefèvre Marino on 2/25/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

import UIKit

class CustomHamburguerItem: UIButton {

    override func draw(_ rect: CGRect) {
        
        let lineThick:CGFloat = 1.0
        let lineLenght:CGFloat = min(bounds.width, bounds.height) * 0.8
        let lineColor: UIColor = UIColor.white
        let marginGap: CGFloat = 8.0
        
        for line in 0...2 {
            let linePath = UIBezierPath()
            linePath.lineWidth = lineThick
            
            //start point of line
            linePath.move(to: CGPoint(
                x: bounds.width/6 - lineLenght/2,
                y: 6.0 * CGFloat(line) + marginGap
            ))
            
            //end point of line
            linePath.addLine(to: CGPoint(
                x: bounds.width/6 + lineLenght/2,
                y: 6.0 * CGFloat(line) + marginGap
            ))

            lineColor.setStroke()
            linePath.stroke()
        }
    }

}
