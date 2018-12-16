//
//  BaseWebService.swift
//  Created by Ali Hassan on 16/12/2018.
//

import Alamofire

class BaseWebService {
    
    internal static let sharedManager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        configuration.httpAdditionalHeaders = [
            "Accept": "application/json"
        ]
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    public init() { }
    
}
