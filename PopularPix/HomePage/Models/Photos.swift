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
    let times_viewed: Int?
    let rating: Double?
    let created_at: String?
    let votes_count: Int?
    let comments_count: Int?
    let image_url: [String]?
    let user: User?
}
