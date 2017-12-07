//
//  ProductDetailSwipeControllerCollectionViewController.swift
//  Walmart
//
//  Created by Sudeep Kanikunnel Surendran on 12/6/17.
//  Copyright © 2017 Sudeep Kanikunnel Surendran. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PagedProductCell"

class ProductDetailSwipeController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var pagedProductDetails: [PagedProductDetail<Product>] = []
    var indexPathSelected: IndexPath = IndexPath(row: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // auto scroll to the selected index
        collectionView.scrollToItem(at: indexPathSelected, at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return pagedProductDetails.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let pageProductDetail = pagedProductDetails[section]
        return pageProductDetail.products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as!PagedProductCell
        // Configure the cell
        let pageProductDetail = self.pagedProductDetails[indexPath.section]
        cell.configureCellWithProduct(product: pageProductDetail.products[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: Memory Management

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ProductDetailSwipeController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
}

extension ProductDetailSwipeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
}
