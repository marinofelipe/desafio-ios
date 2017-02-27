//
//  PullRequestHTTPClient.swift
//  desafio-ios
//
//  Created by Felipe Lefèvre Marino on 2/26/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

import Foundation

typealias completionPRSuccess = (_ pullRequests: [PullRequest]) -> Void
typealias completionPRFailure = (_ statusCode: Int, _ response: Any?, _ error: Error?) -> Void

class PullRequestApi: HTTPClient {
    
    class func getPullRequests(owner: String, repository: String, success: @escaping completionPRSuccess, failure: @escaping completionPRFailure) {
        
        let url = "\(Bundle.main.apiBaseUrl)/repos/\(owner)/\(repository)/pulls"
        
        super.request(method: .GET, url: url, success: { (statusCode, response) in
            
            var pullRequests = [PullRequest]()
            let itemsArray = response.object.array
            
            guard itemsArray != nil else {
                success([])
                return
            }
            
            let items = JSONSerializer(itemsArray!)
            
            for item in items.object {
                let json = JSONSerializer(item.1.object)
                let pullRequest = PullRequestDecode.map(json: json)
                pullRequests.append(pullRequest)
            }
            
            success(pullRequests)
            
        }) { (statusCode, response, error) in
            
            failure(statusCode, response, error)
            
        }
    }
    
}
