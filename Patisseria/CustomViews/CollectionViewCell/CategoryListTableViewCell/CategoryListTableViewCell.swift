//
//  CategoryListTableViewCell.swift
//  Patisseria
//
//  Created by Nicole  on 14/05/23.
//

import UIKit

class CategoryListTableViewCell: UITableViewCell {

    //identifier for this cell
    static let identifier = "CategoryListTableViewCell"
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var productDescLabel: UILabel!
    
    @IBOutlet weak var productPriceLabel: UILabel!
    
    
    //setting up all the products in category
    func setup(prod:Product) {
        productImageView.image = UIImage(named: prod.productImage)
        productNameLabel.text = prod.productName
        productDescLabel.text = prod.productDescription
        productPriceLabel.text = "Price:" + (String)(prod.productPrice)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
