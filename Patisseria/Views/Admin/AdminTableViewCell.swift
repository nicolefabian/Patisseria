//
//  AdminTableViewCell.swift
//  Patisseria
//
//  Created by Alesson Abao on 12/05/23.
//

import UIKit

class AdminTableViewCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productStockLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
