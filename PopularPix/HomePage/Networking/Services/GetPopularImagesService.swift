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
    
    typealias RequestType = GetPopularImagesModel
}



struct GetPopularImagesModel: Codable
{
    let currentPage: Int
    let totalPages: Int
//    let photos: [Photos]
    
    enum CodingKeys: String, CodingKey
    {
        case currentPage = "current_page"
        case totalPages = "total_pages"
    }
}

struct Photos: Codable
{
    let name: String
    let description: String
    let timesViewed: Int
    let rating: Double
    let createdAt: String
    let votesCount: Int
    let commentsCount: Int
    let imageURL: String
    let user: User
}

struct Avatar: Codable
{
    let smallImageURL: AvatarImageDictionary
    let defaultImageURL: AvatarImageDictionary
}

struct AvatarImageDictionary: Codable
{
    let httpsURL: String
    let httpURL: String?
}

struct User: Codable
{
    let username: String
    let avatar: Avatar
}
