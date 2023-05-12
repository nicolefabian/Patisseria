//
//  Product.swift
//  Patisseria
//
//  Created by Alesson Abao on 12/05/23.
//

import Foundation
import UIKit

class Product{
    var productID: Int!
    var productName: String!
    var productDescription: String!
    var productCategory: String?
    var productStock: Int!
    var productPrice: Int!
    var productImage: String!
    
    public init(productID: Int!, productName: String!, productDescription: String!, productCategory: String?, productStock: Int!, productPrice: Int!, productImage: String!) {
        self.productID = productID
        self.productName = productName
        self.productDescription = productDescription
        self.productCategory = productCategory
        self.productStock = productStock
        self.productPrice = productPrice
        self.productImage = productImage
    }
}
