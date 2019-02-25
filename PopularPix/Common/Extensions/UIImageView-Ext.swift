//
//  UIImageView-Ext.swift
//  PopularPix
//
//  Created by Miwand Najafe on 2019-02-24.
//  Copyright © 2019 Miwand Najafe. All rights reserved.
//

import UIKit

extension UIImageView
{
    func getImage(from urlString: String, onCompletion: @escaping (() -> ()))
    {
        guard let imageURL = URL(string: urlString) else { return }
        
        let request = URLRequest(url: imageURL, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 5.0)
        
        let session = URLSession.shared.dataTask(with: request) { [weak self](data, response, error) in
            if error == nil
            {
                guard let data = data else { return }
                let image = UIImage(data: data)
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
            }
            onCompletion()
        }
        session.resume()
    }
}
