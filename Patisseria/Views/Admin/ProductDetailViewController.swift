//
//  ProductDetailViewController.swift
//  Patisseria
//
//  Created by Alesson Abao on 12/05/23.
//
import Foundation
import UIKit

class ProductDetailViewController: UIViewController {
    
    //static let identifier = "ProductDetailViewController"
    // MARK: Outlets
   // @IBOutlet weak var productDetailInfoView: UIView!
    
    @IBOutlet weak var productDetailImageView: UIImageView!
    @IBOutlet weak var productDetailNameLabel: UILabel!
    //@IBOutlet weak var productDetailStockLabel: UILabel!
    @IBOutlet weak var productDetailPriceLabel: UILabel!
    @IBOutlet weak var productDetailDescriptionLabel: UILabel!
    
    var selectedDetailProduct : Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //productDetailInfoView.viewRoundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 20)
        
        productDetailImageView.image = UIImage(named: selectedDetailProduct.productImage)
        productDetailNameLabel.text = selectedDetailProduct.productName
        //productDetailStockLabel.text = "Stock: " + (String)(selectedDetailProduct.productStock)
        productDetailPriceLabel.text = "Price: $" + (String)(selectedDetailProduct.productPrice)
        productDetailDescriptionLabel.text = selectedDetailProduct.productDescription
        
    }

}
