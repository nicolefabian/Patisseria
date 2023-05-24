//
//  VisuallyImpairedProductListTableViewCell.swift
//  Patisseria
//
//  Created by Nicole  on 16/05/23.
//

import UIKit

class VisuallyImpairedProductListTableViewCell: UITableViewCell {

    static let identifier = "VisuallyImpairedCategoryListTableViewCell"
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
