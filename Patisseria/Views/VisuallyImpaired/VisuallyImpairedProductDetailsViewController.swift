//
//  VisuallyImpairedProductDetailsViewController.swift
//  Patisseria
//
//  Created by Nicole  on 16/05/23.
//

import UIKit

class VisuallyImpairedProductDetailsViewController: UIViewController {

    @IBOutlet weak var productDetailImageView: UIImageView!
    @IBOutlet weak var productDetailNameLabel: UILabel!
    @IBOutlet weak var productDetailPriceLabel: UILabel!
    @IBOutlet weak var productDetailDescriptionLabel: UILabel!
    
    var selectedDetailProduct : Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        productDetailImageView.image = UIImage(named: selectedDetailProduct.productImage)
        productDetailNameLabel.text = selectedDetailProduct.productName
        productDetailPriceLabel.text = "Price: $" + (String)(selectedDetailProduct.productPrice)
        productDetailDescriptionLabel.text = selectedDetailProduct.productDescription
        
    }
}
