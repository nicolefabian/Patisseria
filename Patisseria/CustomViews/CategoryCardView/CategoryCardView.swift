//
//  CategoryCardView.swift
//  Patisseria
//
//  Created by Nicole  on 13/05/23.
//

import Foundation
import UIKit

//for collection view cell and table cell design
class CategoryCardView: UIView {
    override init (frame: CGRect) {
        super.init(frame:frame)
        initialSetUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetUp()
    }
    
    private func initialSetUp() {
        layer.shadowColor = UIColor.brown.cgColor
        layer.shadowOffset = .zero
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
        cornerRadius = 10
    }
}
