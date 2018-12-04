//
//  UICollectionView+Extension.swift
//
//  Created by Artem Umanets on 09/02/2018.
//  Copyright © 2018 Bruno Silva by Bold. All rights reserved.
//

import UIKit
 
extension UICollectionReusableView: ReusableView {}

public enum SuplementaryViewKind: RawRepresentable {
    
    case header
    case footer
    
    public init?(rawValue: String) {
        switch rawValue {
        case UICollectionView.elementKindSectionHeader: self = .header
        case UICollectionView.elementKindSectionFooter: self = .footer
        default: return nil
        }
    }
    
    public var rawValue: String {
        switch self {
        case .header: return UICollectionView.elementKindSectionHeader
        case .footer: return UICollectionView.elementKindSectionFooter
        }
    }
}

// MARK: - Register Cells and Suplementary views
public extension UICollectionView {
    
    public func registerNib<T: UICollectionViewCell>(for cellClass: T.Type, in bundle: Bundle? = nil) {
        register(T.nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    public func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    public func register<T: UICollectionReusableView>(_ supplementaryViewClass: T.Type, forSupplementaryViewOfKind supplementaryViewOfKind: String) {
        register(supplementaryViewClass, forSupplementaryViewOfKind: supplementaryViewOfKind, withReuseIdentifier: T.reuseIdentifier)
    }
    
    public func register<T: UICollectionReusableView>(_ supplementaryViewClass: T.Type, for supplementaryViewOfKind: SuplementaryViewKind) {
        register(supplementaryViewClass, forSupplementaryViewOfKind: supplementaryViewOfKind.rawValue, withReuseIdentifier: T.reuseIdentifier)
    }
}

// MARK: - Dequeue cells and supplementary views
public extension UICollectionView {
    
    public func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    public func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: SuplementaryViewKind, for indexPath: IndexPath) -> T {
        return self.dequeueReusableSupplementaryView(ofKind: kind.rawValue, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
