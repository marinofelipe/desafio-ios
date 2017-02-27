//
//  PullRequest.swift
//  desafio-ios
//
//  Created by Felipe Lefèvre Marino on 2/26/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

struct PullRequest {
    
    var title: String
    var body: String
    var date: String
    var url: String
    var state: String
    var ownerNick: String
    var ownerAvatarUrl: String
    
    init(title: String, body: String, date: String, url: String, state: String, ownerNick: String, ownerAvatarUrl: String) {
        self.title = title
        self.body = body
        self.date = date
        self.url = url
        self.state = state
        self.ownerNick = ownerNick
        self.ownerAvatarUrl = ownerAvatarUrl
    }
    
    static func totalStates(_ pulls: [PullRequest]) -> (Int, Int) {
        
        var totals = (open: 0, closed: 0)
        
        for pull in pulls {
            switch pull.state {
            case "open":
                totals.open += 1
            case "closed":
                totals.closed += 1
            default:
                break;
            }
        }
        
        return totals
    }

}
