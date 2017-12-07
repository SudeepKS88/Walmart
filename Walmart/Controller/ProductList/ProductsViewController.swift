//
//  ProductsViewController.swift
//  Walmart
//
//  Created by Sudeep Kanikunnel Surendran on 12/2/17.
//  Copyright © 2017 Sudeep Kanikunnel Surendran. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {
   
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var productsTableview: UITableView!
    fileprivate let productPresenter = ProductListPresenter()
    fileprivate var lastIndexPath: IndexPath? = nil
    
    var pagedProductDetails: [PagedProductDetail<Product>] = [] {
        didSet {
            lastIndexPath = self.calculateLastIndexPath()
            DispatchQueue.main.async {
                self.productsTableview.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productsTableview.isHidden = true
        activityIndicator.hidesWhenStopped = true

        productPresenter.loadProducts { [weak self] (pagedProductsDetails) in
            if let pagedProductsDetails = pagedProductsDetails {
                self?.pagedProductDetails.append(pagedProductsDetails)
                DispatchQueue.main.async {
                    self?.productsTableview.isHidden = false
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }

    func calculateLastIndexPath() -> IndexPath? {
        guard let lastPage = pagedProductDetails.last else {
            return nil
        }
        return IndexPath(row: lastPage.products.count - 1, section: lastPage.pageNumber)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ProductsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return pagedProductDetails.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let pageProductDetail = pagedProductDetails[section]
        return pageProductDetail.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as! ProductTableViewCell
        let pageProductDetail = self.pagedProductDetails[indexPath.section]
        cell.configureCell(withProduct: pageProductDetail.products[indexPath.row])
        
        return cell
    }
}

extension ProductsViewController: UITableViewDelegate {
    
    fileprivate var nextPage: Int {
        guard let lastPage = pagedProductDetails.last else {
            return 0
        }
        return lastPage.pageNumber.advanced(by: 1)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath == lastIndexPath) {
            self.productPresenter.loadProducts(page: nextPage, resultsPerPage: 10) { [weak self] (pagedProductsDetails) in
                if let pagedProductsDetails = pagedProductsDetails {
                    self?.pagedProductDetails.append(pagedProductsDetails)
                }
            }
        }
    }
}

extension ProductsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ProductDetailSwipe") {
            if let destination = segue.destination as? ProductDetailSwipeController {
                if let indexPath = self.productsTableview.indexPathForSelectedRow {
                    destination.pagedProductDetails = self.pagedProductDetails
                    destination.indexPathSelected = indexPath
                }
            }
        }
    }
}


