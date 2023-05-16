//
//  Category.swift
//  Patisseria
//
//  Created by Nicole  on 15/05/23.
//

import Foundation
import UIKit

class Category {
    
    var productCategoryName: String?
    var productCategoryImage: String!
    //Constructor
    public init(productCategory: String, productImage: String) {
        self.productCategoryName = productCategory
        self.productCategoryImage = productImage
    }
}
