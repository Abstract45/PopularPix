//
//  Photos.swift
//  PopularPix
//
//  Created by Miwand Najafe on 2019-02-24.
//  Copyright © 2019 Miwand Najafe. All rights reserved.
//

import Foundation

struct Photos: Codable
{
    let name: String?
    let description: String?
    let timesViewed: Int?
    let rating: Double?
    let createdAt: String?
    let votesCount: Int?
    let commentsCount: Int?
    let imageURL: [String]?
    let user: User?
    
    enum CodingKeys: String, CodingKey
    {
        case name, description, rating, user
        case timesViewed = "times_viewed"
        case createdAt = "created_at"
        case votesCount = "votes_count"
        case commentsCount = "comments_count"
        case imageURL = "image_url"
    }
}
