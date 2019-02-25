//
//  MainPageVC.swift
//  PopularPix
//
//  Created by Miwand Najafe on 2019-02-24.
//  Copyright © 2019 Miwand Najafe. All rights reserved.
//

import UIKit

class MainPageVC: UIViewController
{
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    fileprivate(set) var photoCount = 0
    fileprivate var imageService: GetPopularImagesService = GetPopularImagesService()
    fileprivate let screenWidth = UIScreen.main.bounds.width
    fileprivate var detailsVC: DetailsViewController?
    var popularImageResponseModel: PopularImagesResponseModel?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.register(UINib(nibName: "MainPageCollectionCell", bundle: nil), forCellWithReuseIdentifier: "mainPageCell")
        self.setupLayout()
        self.fetchData(for: 1)
        self.navigationItem.title = "Popular Pix"
    }
    
    func setupLayout()
    {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        self.collectionView.collectionViewLayout = layout
    }
}

extension MainPageVC
{
    func fetchData(for pageNumber: Int)
    {
        imageService.update(pageNumber: pageNumber)
        activityIndicatorView.startAnimating()
        imageService.execute(onSuccess: { [weak self] (responseModel) in
            var startIndexCount = 0
            var endIndexCount = responseModel.photos.count
            if self?.popularImageResponseModel == nil
            {
                self?.popularImageResponseModel = responseModel
            }
            else if let oldPhotos = self?.popularImageResponseModel?.photos
            {
                var tempModel = responseModel
                startIndexCount = oldPhotos.count
                endIndexCount += startIndexCount
                tempModel.update(photos: oldPhotos)
                self?.popularImageResponseModel = tempModel
            }
            DispatchQueue.main.async
            { [weak self] in
                self?.activityIndicatorView.stopAnimating()
                if startIndexCount == 0
                {
                    self?.collectionView.reloadData()
                }
                else
                {
                    let indexPaths: [IndexPath] =
                        Array(startIndexCount..<endIndexCount).compactMap({ IndexPath(item: $0, section: 0)})
                    
                    self?.collectionView.performBatchUpdates({ [weak self] in
                        self?.collectionView.insertItems(at: indexPaths)
                        }, completion: nil)
                }
            }
        }) { (error) in
            // Add error handling here
            print("Error occurred: \(error)")
            DispatchQueue.main.async
            { [weak self] in
                self?.activityIndicatorView.stopAnimating()
            }
        }
    }
    
    func presentDetailsVC(with indexPath: IndexPath)
    {
        detailsVC =             self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        if let photoData = self.popularImageResponseModel?.photos[indexPath.row]
        {
            detailsVC?.photo = photoData
        }
        self.navigationController?.pushViewController(detailsVC!, animated: true)
    }
}

extension MainPageVC: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        self.presentDetailsVC(with: indexPath)
    }
}

extension MainPageVC: UICollectionViewDataSourcePrefetching
{
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath])
    {
       if !self.activityIndicatorView.isAnimating,
        let responseModel = self.popularImageResponseModel,
        indexPaths.contains(where: { $0.row >= responseModel.photos.count - 1 })
       {
            self.fetchData(for: responseModel.currentPage + 1)
        }
    }
}

extension MainPageVC: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.popularImageResponseModel?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainPageCell", for: indexPath) as? MainPageCollectionCell else
        {
            return UICollectionViewCell()
        }
        cell.configCell(with: popularImageResponseModel?.photos[indexPath.row].imageURL?.first)
        return cell
    }
}
