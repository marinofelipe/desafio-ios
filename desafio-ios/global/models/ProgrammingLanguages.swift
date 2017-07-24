//
//  ProgrammingLanguages.swift
//  desafio-ios
//
//  Created by Felipe Marino on 24/07/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

public enum ProgramLanguage: String {
    case swift, objectivec, java, python, javascript, ruby, kotlin
}

public struct ProgrammingLanguages {
    
    static let shared = ProgrammingLanguages()
    
    let optionSet: [ProgramLanguage] = [.swift, .objectivec, .java, .python, .javascript, .ruby, .kotlin]
}
