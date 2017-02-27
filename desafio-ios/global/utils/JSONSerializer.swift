//
//  JSONSerializer.swift
//  desafio-ios
//
//  Created by Felipe Lefèvre Marino on 2/26/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

import SwiftyJSON

typealias completionJSONSuccess = (_ statusCode: Int, _ response: JSONSerializer) -> Void
typealias completionJSONFailure = (_ statusCode: Int, _ response: Any?, _ error: Error?) -> Void

class JSONSerializer {
    
    var object: JSON
    
    init(_ object: Any) {
        self.object = JSON(object)
    }
    
}
