//
//  UIView+Extension.swift
//  Patisseria
//
//  Created by Alesson Abao on 4/05/23.
//

import Foundation
import UIKit

extension UIView{
    
    // add corner radius in storyboard for buttons
    @IBInspectable var cornerRadius: CGFloat{
        get{
            return self.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
        }
    }
}
