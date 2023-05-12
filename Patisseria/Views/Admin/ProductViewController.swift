//
//  ProductViewController.swift
//  Patisseria
//
//  Created by Alesson Abao on 12/05/23.
//

import UIKit

class ProductViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var productTableView: UITableView!
    
    var defaultProducts = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initProductList()
    }
    // MARK: initial productList
    func initProductList(){
        let bread1 = Product(productID: 1, productName: "Pandesal", productDescription: "Classic filipino bread. Pandesal is a staple bread roll in the Philippines commonly eaten for breakfast. It is made of flour, yeast, sugar, oil, and salt.", productCategory: "", productStock: 20, productPrice: 1, productImage: "pandesal")
        defaultProducts.append(bread1)
        
        let bread2 = Product(productID: 2, productName: "challahbread", productDescription: "Challah is a special bread of Ashkenazi Jewish origin, usually braided and typically eaten on ceremonial occasions such as Shabbat and major Jewish holidays. Ritually acceptable challah is made of dough from which a small portion has been set aside as an offering. Challah may also refer to the dough offering.", productCategory: "", productStock: 1, productPrice: 2, productImage: "challahbread")
        defaultProducts.append(bread2)
        
        let bread3 = Product(productID: 3, productName: "Cream Cheese Garlic Bread", productDescription: "Korean cream cheese garlic bread is a popular Korean street food featuring a twist on classic garlic bread. Rather than using loaves of bread, this garlic bread uses medium size rolls, about 5 inches wide, that's been cut into wedges. The bread is filled with sweetened cream cheese and a dunked in a garlic butter 'custard.'", productCategory: "New", productStock: 20, productPrice: 5, productImage: "creamcheesepan")
        defaultProducts.append(bread3)
        
        let bread4 = Product(productID: 4, productName: "Cross Bun", productDescription: "A hot cross bun is a spiced bun usually made with fruit, marked with a cross on the top, which has been traditionally eaten on Good Friday in the United Kingdom, Australia, New Zealand, South Africa, Canada, India, Pakistan, Malta, United States and the Commonwealth Caribbean.", productCategory: "Popular", productStock: 2, productPrice: 1, productImage: "crossbuns")
        defaultProducts.append(bread4)
        
        let bread5 = Product(productID: 5, productName: "Ensaymada", productDescription: "Ensaymada is a Filipino brioche: tender, fluffy, lightly sweet and popular in Philippine bakeries. This Filipino bread originates from the Spanish ensaimada and is a classic merienda (snack) favorite.", productCategory: "", productStock: 3, productPrice: 4, productImage: "filbread")
        defaultProducts.append(bread5)
        
        let bread6 = Product(productID: 6, productName: "Keto Bread", productDescription: "keto bread is a low carb alternative to a traditional sandwich and toast bread. Unlike the traditional kind, it doesn't contain any white or wheat flour. Instead, it's made with almond flour and often doesn't require any yeast.", productCategory: "Keto", productStock: 20, productPrice: 1, productImage: "ketobread")
        defaultProducts.append(bread6)
        
        let bread7 = Product(productID: 7, productName: "Melon Pan", productDescription: "A melonpan is a type of Japanese sweetbun that is well-known across the country and widely popular throughout China and Taiwan. The sweetbun is made from an enriched dough covered in a thin layer of crisp cookie dough. Their appearance resembles a melon, such as a rock melon.", productCategory: "Popular", productStock: 2, productPrice: 4, productImage: "melonpan")
        defaultProducts.append(bread7)
        
        let bread8 = Product(productID: 8, productName: "Milk Bread", productDescription: "Milk bread is a delightful and versatile type of bread that is known for its soft, fluffy texture and slightly sweet taste. This bread variation incorporates milk into the dough, resulting in a tender crumb and a subtle richness that sets it apart from other bread types.", productCategory: "", productStock: 20, productPrice: 1, productImage: "milkbread")
        defaultProducts.append(bread8)
        
        let bread9 = Product(productID: 9, productName: "Scallion Bread", productDescription: "Introducing Scallion Bread, a flavorful and aromatic delight that brings a unique twist to traditional bread. Bursting with the fresh and vibrant taste of scallions (green onions), this bread is a culinary masterpiece that adds a burst of savory goodness to any meal.", productCategory: "", productStock: 20, productPrice: 1, productImage: "scallionbread")
        defaultProducts.append(bread9)
        
        let bread10 = Product(productID: 10, productName: "Ube Pandesal", productDescription: "Ube Pandesal is a Filipino bread sensation that captures the hearts and palates of food lovers everywhere. This vibrant purple bread is made with the distinctive flavor of ube, a purple yam widely enjoyed in Filipino cuisine.", productCategory: "Popular", productStock: 20, productPrice: 1, productImage: "ubepan")
        defaultProducts.append(bread10)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defaultProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productID", for: indexPath) as! AdminTableViewCell

        let thisProduct = defaultProducts[indexPath.row]
        
        cell.productImage.image = UIImage(named: thisProduct.productImage)
        cell.productNameLabel.text = thisProduct.productName
        cell.productStockLabel.text = "Stock:" + (String)(thisProduct.productStock)
        
        return cell
    }

    // MARK: Functions to go to product detail when row is clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "productDetail", sender: self)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "productDetail"){
            let indexPath = self.productTableView.indexPathForSelectedRow!
            let productDetail = segue.destination as? ProductDetailViewController
            
            let selectedProduct = defaultProducts[indexPath.row]
            
            productDetail!.selectedDetailProduct = selectedProduct
            self.productTableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
