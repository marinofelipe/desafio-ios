//
//  InterfaceController.swift
//  desafio-ios-watch Extension
//
//  Created by Felipe Marino on 24/07/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

import WatchKit
import WatchConnectivity

class InterfaceController: WKInterfaceController {

    @IBOutlet var tableView: WKInterfaceTable!
    private let programLanguages = ProgrammingLanguages.shared
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        setupTable()
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    private func setupTable() {
        tableView.setNumberOfRows(programLanguages.optionSet.count, withRowType: "LanguageRowType")
        for (index, language) in programLanguages.optionSet.enumerated() {
            if let row = tableView.rowController(at: index) as? LanguageRowType {
                row.name.setText(language.rawValue)
            }
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        print("selected row: \(rowIndex)")
        sendToParentAppSelected(language: programLanguages.optionSet[rowIndex])
    }
    
    private func sendToParentAppSelected(language: ProgramLanguage) {
        //FIXME: 1. Make send again only when reply is received - 2. Add activity indicator or progress view to stop user from selecting another option
        let dict = ["selectedLanguage": language.rawValue]
        WCSession.default().sendMessage(dict, replyHandler: { (replyDict) in
            print("received from parent app as reply: \(replyDict)")
        }) { (error) in
            print("error \(error) on sending message to parent app")
        }
    }
}
