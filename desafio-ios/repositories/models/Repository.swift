//
//  Repository.swift
//  desafio-ios
//
//  Created by Felipe Lefèvre Marino on 2/25/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

struct Repository {
    
    var name: String
    var description: String
    var forks: Int
    var favorites: Int
    var ownerNick: String
    var ownerAvatarUrl: String
    var ownerFullName: String
    
    init(name: String, description: String, forks: Int, favorites: Int, ownerNick: String, ownerAvatarUrl: String, ownerFullName: String) {
        self.name = name
        self.description = description
        self.forks = forks
        self.favorites = favorites
        self.ownerNick = ownerNick
        self.ownerAvatarUrl = ownerAvatarUrl
        self.ownerFullName = ownerFullName
    }
    
}
