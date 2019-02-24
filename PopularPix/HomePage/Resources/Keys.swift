//
//  Keys.swift
//  PopularPix
//
//  Created by Miwand Najafe on 2019-02-24.
//  Copyright © 2019 Miwand Najafe. All rights reserved.
//

import Foundation

struct Keys
{
    static func getConsumerKey() -> String //Add your consumerKey Here
    {
        let key = ""
        precondition(!key.isEmpty, "Enter your consumer Key!")
        return key
    }
    
}
