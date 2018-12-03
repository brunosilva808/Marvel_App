//
//  UIView+UINib.swift
//
//  Created by Artem Umanets on 06/02/2018.
//  Copyright © 2018 Carbon by Bold. All rights reserved.
//

import UIKit

public extension UIView {
    
    static func fromNib() -> Self  {
        
        func instanceFromNib<T: UIView>() -> T {
            
            return UINib(nibName: "\(self)", bundle: nil).instantiate(withOwner: nil, options: nil).first as! T
        }
        return instanceFromNib()
    }
}
