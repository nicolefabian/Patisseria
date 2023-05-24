//
//  VisualImpairedViewController.swift
//  Patisseria
//
//  Created by Nicole on 14/05/23.
//

import UIKit


class VisualImpairedViewController: UIViewController {
    
    @IBOutlet weak var productSearchBar: UISearchBar!
    
    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        initCategoryList()
        // Do any additional setup after loading the view.
        registerCells()
        registerTableCells()
        initProductList()
        //setting the searchProd to display all products upon loading
        searchedProd = defaultProducts
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

extension VisualImpairedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate  {
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
            let controller = VisuallyImpairedProductListViewController.instantiate()
            navigationController?.pushViewController(controller, animated: true)
        } else  {
            let controller = VisuallyImpairedProductListViewController.instantiate()
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    //--TABLE VIEW------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //displaying all the products
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
        let controller = VisuallyImpairedProductDetailsViewController.instantiate()
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
