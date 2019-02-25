//
//  MainPageCollectionCell.swift
//  PopularPix
//
//  Created by Miwand Najafe on 2019-02-24.
//  Copyright © 2019 Miwand Najafe. All rights reserved.
//

import UIKit

class MainPageCollectionCell: UICollectionViewCell
{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    func configCell(with URLString: String?)
    {
        guard let urlString = URLString else {
            self.imageView.image = nil
            return
        }
        self.indicatorView.startAnimating()
        self.imageView.getImage(from: urlString) {
            DispatchQueue.main.async { [weak self] in
                self?.indicatorView.stopAnimating()
            }
        }
    }

}
