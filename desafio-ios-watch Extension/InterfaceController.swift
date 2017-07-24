//
//  InterfaceController.swift
//  desafio-ios-watch Extension
//
//  Created by Felipe Marino on 24/07/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var tableView: WKInterfaceTable!
    //TODO: thorw languages in a model. See if model can be interacted by iphone and watch. Use for both
    private let programLangauges = ["swift", "objectivec", "java", "python", "javascript", "ruby", "kotlin"]
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        setupTable()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    private func setupTable() {
        tableView.setNumberOfRows(programLangauges.count, withRowType: "LanguageRowType")
        for (index, language) in programLangauges.enumerated() {
            if let row = tableView.rowController(at: index) as? LanguageRowType {
                row.name.setText(language)
            }
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        print("selected row: \(rowIndex)")
    }
}
