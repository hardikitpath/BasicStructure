//
//  ResuseableView.swift
//  DelegationDemo
//
//  Created by scooby systems on 31/07/19.
//  Copyright © 2019 Hardik Modja. All rights reserved.
//

import UIKit

public protocol ResuseableView {
    static var identifier: String { get }
}

public extension ResuseableView where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ResuseableView {}
extension UITableViewHeaderFooterView: ResuseableView {}
extension UICollectionReusableView : ResuseableView {}

public protocol NibLoadable {
    static var nibName: String { get }
}

public extension NibLoadable where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

extension UITableViewCell: NibLoadable {}
extension UITableViewHeaderFooterView: NibLoadable {}
extension UICollectionReusableView: NibLoadable {}


public extension UITableView {
    func register<T: UITableViewCell>(_ : T.Type)  {
        register(T.self, forCellReuseIdentifier: T.identifier)
    }
    
    func registerNib<T: UITableViewCell>(_ : T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.identifier)
    }
    
    func register<T: UITableViewHeaderFooterView>(_ : T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.identifier)
    }
    
    func registerNibFoooterHeaderView<T: UITableViewHeaderFooterView>(_ : T.Type) {
        let reuseIdentifier = T.identifier
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueHeaderFooterView<T: UITableViewHeaderFooterView>(_ : T.Type) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as? T
    }
    
    func dequeueReuseableCell<T: UITableViewCell>(_ :T.Type, at indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T
    }
}

public extension UICollectionView {
    func register<T: UICollectionReusableView>(_ : T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.identifier)
    }
    
    func register<T: UICollectionReusableView>(_ : T.Type, ofKind kind: String) {
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.identifier)
    }
    
    func registerNib<T: UICollectionReusableView>(_ : T.Type) {
        let reuseIdentifer = T.identifier
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: reuseIdentifer)
    }
    
    func registerNib<T: UICollectionReusableView>(_ : T.Type, ofKind kind: String) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ : T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier,
                                           for: indexPath) as? T else {
                                            fatalError("Please verify cell identifier \(T.identifier)")
        }
        return cell
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionViewCell>(_ : T.Type, ofKind kind: String, for indexPath: IndexPath) -> T? {
        return dequeueReusableSupplementaryView(ofKind: kind,
                                                withReuseIdentifier: T.identifier,
                                                for: indexPath) as? T
    }
}
