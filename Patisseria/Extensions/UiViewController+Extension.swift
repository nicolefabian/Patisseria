//
//  UiViewController+Extension.swift
//  Patisseria
//
//  Created by Nicole  on 14/05/23.
//

import Foundation
//for UiViewController
import UIKit

extension UIViewController {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    //for storyboard navigation
    static func instantiate() -> Self
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}
