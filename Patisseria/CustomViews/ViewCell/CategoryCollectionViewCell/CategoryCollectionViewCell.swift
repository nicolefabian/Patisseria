//
//  CategoryCollectionViewCell.swift
//  Patisseria
//
//  Created by Nicole  on 13/05/23.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    static let categoryIdentifier = String(describing: CategoryCollectionViewCell.self)
    
    @IBOutlet weak var categoryImageView: UIImageView!
    
    @IBOutlet weak var categoryTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }
   
    
    //getting from the Category Model
    func setupProductCategoryCollectionCell (category: Category) {
        categoryTextLabel.text = category.productCategoryName
        categoryImageView.image = UIImage(named: category.productCategoryImage )
    }
}
