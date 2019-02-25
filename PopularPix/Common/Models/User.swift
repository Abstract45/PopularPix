//
//  User.swift
//  PopularPix
//
//  Created by Miwand Najafe on 2019-02-24.
//  Copyright © 2019 Miwand Najafe. All rights reserved.
//

import Foundation


struct User: Codable
{
    let username: String?
    let avatars: Avatar?
}

struct Avatar: Codable
{
    let small: AvatarImageDictionary?
    let `default`: AvatarImageDictionary?
}

struct AvatarImageDictionary: Codable
{
    let https: String?
}
