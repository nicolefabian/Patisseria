//
//  RegularViewController.swift
//  Patisseria
//
//  Created by Nicole Fabian on 14/05/23.
//

import UIKit


var defaultCategory = [Category]()
var searchedProd = [Product]()

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
    let cat5 = Category(productCategory: "Desserts", productImage: "categorydessert")
    defaultCategory.append(cat5)
}

class RegularViewController: UIViewController {
    @IBOutlet weak var productSearchBar: UISearchBar!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var productsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //loading category
        initCategoryList()
        //loading the collection cell
        registerCells()
        //loading the table cell
        registerTableCells()
        //loading the products
        initProductList()
        //setting the searchProd to display all products upon loading
        searchedProd = defaultProducts
    }

    private func registerCells() {
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.categoryIdentifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.categoryIdentifier)
    }
    
    private func registerTableCells() {
        //loading the cells to the table view
        productsTableView.register(UINib(nibName: CategoryListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CategoryListTableViewCell.identifier)
    }
    
    
}

extension RegularViewController: UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate  {
    
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
            navigationController?.pushViewController(controller, animated: true)
        } else  {
            let controller = CategoryListViewController.instantiate()
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    //--TABLE VIEW------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //displaying all the products
        print("hello searchProd count:", searchedProd.count)
        return searchedProd.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryListTableViewCell.identifier) as! CategoryListTableViewCell
        //displaying all the elements inside the cell
        cell.setup(prod: searchedProd[indexPath.row])
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //loading the ProductDetailViewController
        let controller = ProductDetailViewController.instantiate()
        controller.selectedDetailProduct = searchedProd[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //---SEARCH----
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedProd = []
        if searchText == "" {
            searchedProd = defaultProducts
        }
   
        for eachProd in defaultProducts {
            if eachProd.productName.lowercased().contains(searchText.lowercased()) {
                searchedProd.append(eachProd)
            }
        }
        //reload the table
        productsTableView.reloadData()
    }

}
