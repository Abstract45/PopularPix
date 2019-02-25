//
//  GetPopularImagesService.swift
//  PopularPix
//
//  Created by Miwand Najafe on 2019-02-24.
//  Copyright © 2019 Miwand Najafe. All rights reserved.
//

import Foundation

struct GetPopularImagesService: APIClient
{
    fileprivate(set) var pageNumber: Int = 1
    
    var request: RequestDataModel
    {
        return RequestDataModel(
            path: "https://api.500px.com/v1/photos?",
            params: [
                "feature": "popular",
                "consumer_key": Keys.getConsumerKey(),
                "page": "\(self.pageNumber)"
            ],
            headers: self.getDefaultHeaders())
    }
    
    mutating func update(pageNumber: Int)
    {
        self.pageNumber = pageNumber
    }
    
    typealias RequestType = PopularImagesResponseModel
}

