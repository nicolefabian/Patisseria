//
//  RegularViewController.swift
//  Patisseria
//
//  Created by Nicole Fabian on 14/05/23.
//

import UIKit


var defaultCategory = [Category]()

// MARK: initial productList
func initCategoryList(){
    let cat1 = Category(productCategory: "Fresh Bread", productImage: "categoryfreshbread")
    defaultCategory.append(cat1)
    let cat2 = Category(productCategory: "Filipino Bread", productImage: "categoryfilbread")
    defaultCategory.append(cat2)
    let cat3 = Category(productCategory: "Asian pastries", productImage: "categoryasianpastries")
    defaultCategory.append(cat3)
    let cat4 = Category(productCategory: "Special Cakes", productImage: "categorycake")
    defaultCategory.append(cat4)
}

class RegularViewController: UIViewController {
    @IBOutlet weak var productSearchBar: UISearchBar!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var productsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initCategoryList()
        // Do any additional setup after loading the view.
        registerCells()
        registerTableCells()
        initProductList()
        
        print("hi",defaultCategory.count)
    }

    private func registerCells() {
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.categoryIdentifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.categoryIdentifier)
    }
    
    private func registerTableCells() {
        //loading the cells to the table view
        productsTableView.register(UINib(nibName: CategoryListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CategoryListTableViewCell.identifier)
    }
}

extension RegularViewController: UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return defaultCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.categoryIdentifier, for: indexPath) as! CategoryCollectionViewCell
      
        cell.setupProductCategoryCollectionCell(category: defaultCategory[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            let controller = CategoryListViewController.instantiate()
           // controller.productShowedInList = defaultProducts[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        } else  {
            let controller = CategoryListViewController.instantiate()
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    //--TABLE VIEW------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //displaying all the products
        print("hello", defaultProducts.count)
        return defaultProducts.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryListTableViewCell.identifier) as! CategoryListTableViewCell
        //displaying all the elements inside the cell
        cell.setup(prod: defaultProducts[indexPath.row])
        //displaying each site
        //cell.siteNameLabel.text = searchedSites[indexPath.row].siteName
        //cell.productImage.image = UIImage(named: thisProduct.productImage)
        print(cell)
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //loading the ProductDetailViewController
        let controller = ProductDetailViewController.instantiate()
        controller.selectedDetailProduct = defaultProducts[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }

}
