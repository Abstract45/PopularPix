//
//  DetailsViewController.swift
//  PopularPix
//
//  Created by Miwand Najafe on 2019-02-24.
//  Copyright © 2019 Miwand Najafe. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController
{
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var detailView: UIView!
    
    var photo: Photos!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.loadData()
        self.navigationItem.title = photo.name
    }
    
    func loadData()
    {
        if let mainImageURLString = photo.imageURL?.last
        {
            self.mainImage.getImage(from: mainImageURLString, onCompletion: {})
        }
        if let userImageURLString = photo.user?.avatars?.default?.https
        {
            self.userImage.getImage(from: userImageURLString, onCompletion: {})
        }
        self.usernameLabel.text = photo.user?.username
        if let description = photo.description,
            !description.isEmpty
        {
            self.detailView.isHidden = false
            self.descriptionTextView.text = description
            self.descriptionTextView.contentOffset = CGPoint.zero
        }
    }
}

