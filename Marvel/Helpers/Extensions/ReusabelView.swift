//
//  ReusableView.swift
//
//  Created by Bruno Silva on 09/02/2018.
//  Copyright © 2018 Carbon by Bold. All rights reserved.
//

import UIKit

public protocol ReusableView: class {
    
    static var reuseIdentifier: String { get }
    static var nib: UINib { get }
}

public extension ReusableView {
    
    static var reuseIdentifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: self.reuseIdentifier, bundle: nil) }
}
