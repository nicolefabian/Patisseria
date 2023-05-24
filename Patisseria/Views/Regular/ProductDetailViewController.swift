//
//  ProductDetailViewController.swift
//  Patisseria
//
//  Created by Alesson Abao on 12/05/23.
//
import Foundation
import UIKit

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var productDetailImageView: UIImageView!
    @IBOutlet weak var productDetailNameLabel: UILabel!
    @IBOutlet weak var productDetailPriceLabel: UILabel!
    @IBOutlet weak var productDetailDescriptionLabel: UILabel!
    
    var selectedDetailProduct : Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productDetailImageView.image = UIImage(named: selectedDetailProduct.productImage)
        productDetailNameLabel.text = selectedDetailProduct.productName
        productDetailPriceLabel.text = "Price: $" + (String)(selectedDetailProduct.productPrice)
        productDetailDescriptionLabel.text = selectedDetailProduct.productDescription
        
    }

}
