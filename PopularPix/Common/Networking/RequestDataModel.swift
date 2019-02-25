//
//  RequestDataModel.swift
//  PopularPix
//
//  Created by Miwand Najafe on 2019-02-24.
//  Copyright © 2019 Miwand Najafe. All rights reserved.
//

import Foundation

enum HTTPMethod: String
{
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
    case post = "POST"
}

struct RequestDataModel
{
    let path: String
    let method: HTTPMethod
    let params: [String: Any]?
    let headers: [String: String]?
    let timeoutInterval: TimeInterval
    let cachePolicy: URLRequest.CachePolicy
    
    init(path: String,
         method: HTTPMethod = .get,
         params: [String: String]? = nil,
         headers: [String: String]? = nil,
         timeoutInterval: TimeInterval = 10.0,
         urlCachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData)
    {
        self.path = path
        self.method = method
        self.params = params
        self.headers = headers
        self.timeoutInterval = timeoutInterval
        self.cachePolicy = urlCachePolicy
    }
}
