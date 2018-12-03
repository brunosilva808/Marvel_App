//
//  UITableVew+Extension.swift
//
//  Created by Bruno Silva on 09/02/2018.
//  Copyright © 2018 Carbon by Bold. All rights reserved.
//

import UIKit

extension UITableViewCell: ReusableView { }
extension UITableViewHeaderFooterView: ReusableView { }

public extension UITableView {
    
    public func registerNib<T: UITableViewCell>(for cellClass: T.Type, in bundle: Bundle? = nil) {
        
        register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    public func register<T: UITableViewCell>(_ cellClass: T.Type) {
        
        register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }
    
    public func registerHeaderFooter<T: UITableViewHeaderFooterView>(_ cellClass: T.Type) {
        register(cellClass, forHeaderFooterViewReuseIdentifier: cellClass.reuseIdentifier)
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    public func dequeueReusableHeaderFooter<T: UITableViewHeaderFooterView>(for section: Int) -> T {
        
        return self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T
    }
    
    public func cell<T: UITableViewCell>(at indexPath: IndexPath) -> T {
        
        return self.cellForRow(at: indexPath) as! T
    }
}

public protocol ModelPresenterCell {
    
    associatedtype Model
    var model: Model? { get set}
}

extension UITableView {
    
    func setTopBounce(color: UIColor = .white, size: CGSize = UIScreen.main.bounds.size) {
        let view = UIView(frame: CGRect(x: self.bounds.origin.x, y: -size.height, width: size.width, height: size.height))
        view.backgroundColor = color
        self.addSubview(view)
    }
    
    public func reusableCell<T: UITableViewCell>(for indexPath: IndexPath, with model: T.Model) -> T where T: ModelPresenterCell {
        
        var cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
        cell.model = model
        return cell
    }
    
    func cell<T: UITableViewCell>(for type: T.Type) -> T {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier) as! T
    }
}

