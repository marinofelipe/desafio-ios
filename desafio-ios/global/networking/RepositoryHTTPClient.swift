//
//  RepositoryHTTPClient.swift
//  desafio-ios
//
//  Created by Felipe Lefèvre Marino on 2/26/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

import Foundation

internal enum ProgramLanguage: String {
    case swift = "Swift"
    case objectivec = "ObjectiveC"
    case java = "Java"
    case python = "Python"
    case javascript = "Javascript"
    case ruby = "Ruby"
    case kotlin = "Kotlin"
}

internal typealias completionRepositorySuccess = (_ repositories: [Repository]) -> Void
internal typealias completionRepositoryFailure = (_ statusCode: Int, _ response: Any?, _ error: Error?) -> Void

class RepositoryHTTPClient: HTTPClient {
    
    class func getRepositories(language: ProgramLanguage = .java, page: Int, success: @escaping completionRepositorySuccess, failure: @escaping completionRepositoryFailure) {
        
        let url = "\(Bundle.main.apiBaseUrl)/search/repositories?q=language:\(language.rawValue)&sort=stars&page=\(page)"
        
        super.request(method: .GET, url: url, success: { (statusCode, response) in
            
            var repositories = [Repository]()
            let itemsArray = response.object["items"].array
            
            guard itemsArray != nil else {
                success([])
                return
            }
            
            let items = JSONSerializer(itemsArray!)
            
            for item in items.object {
                let json = JSONSerializer(item.1.object)
                let repository = RepositoryDecode.map(json: json)
                repositories.append(repository)
            }
            
            success(repositories)
            
        }) { (statusCode, response, error) in
            
            failure(statusCode, response, error)
            
        }
    }
}
