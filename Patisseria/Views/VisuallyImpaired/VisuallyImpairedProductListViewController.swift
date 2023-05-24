//
//  VisuallyImpairedProductListViewController.swift
//  Patisseria
//
//  Created by Nicole  on 16/05/23.
//

import UIKit

class VisuallyImpairedProductListViewController: UIViewController {
    
    @IBOutlet weak var categoryListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //initProductList()
        //adding the categorylisttableviewcell into the view
       // registerCells()
        //print(defaultProducts.count)
        searchedProd = defaultProducts
    }
}

extension VisuallyImpairedProductListViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //displaying all the products
            return defaultProducts.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "productID", for: indexPath) as! VisuallyImpairedProductListTableViewCell

            let thisProduct = searchedProd[indexPath.row]
            
            cell.productImageView.image = UIImage(named: thisProduct.productImage)
            cell.productNameLabel.text = thisProduct.productName
            cell.productPriceNameLabel.text = "Price: $" + (String)(thisProduct.productPrice)
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //loading the ProductDetailViewController
            let controller = VisuallyImpairedProductDetailsViewController.instantiate()
            controller.selectedDetailProduct = searchedProd[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        }
    }

