//
//  PopularImagesResponse.swift
//  PopularPix
//
//  Created by Miwand Najafe on 2019-02-24.
//  Copyright © 2019 Miwand Najafe. All rights reserved.
//

import Foundation

struct PopularImagesResponseModel: Codable
{
    let currentPage: Int
    let totalPages: Int
    let photos: [Photos]
    
    enum CodingKeys: String, CodingKey
    {
        case currentPage = "current_page"
        case totalPages = "total_pages"
        case photos
    }
}
