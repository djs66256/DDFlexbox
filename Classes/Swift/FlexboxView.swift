//
//  FlexboxView.swift
//  FlexboxSwift
//
//  Created by Daniel on 2021/9/15.
//

import UIKit

/// A flexbox
public protocol FlexboxView : AnyObject {
    var flexbox : Flexbox { get }
    
    func updateFlexboxLayout()
    
    func setNeedsUpdateFlexboxLayout()
    func updateFlexboxLayoutIfNeeded()
}

public extension FlexboxView {
    
    /// When flexbox view is not an UIView, it is a virtual node.
    func newFlexbox() -> Flexbox {
        return FlexboxNode(view: nil, hostView: self, textNode: false)
    }
    
    func setNeedsUpdateFlexboxLayout() {
        flexbox.setNeedsUpdateFlexboxLayout()
    }
    
    func updateFlexboxLayoutIfNeeded() {
        flexbox.updateFlexboxLayoutIfNeeded()
    }
}

public extension FlexboxView where Self : UIView {
    
    func newFlexbox() -> Flexbox {
        return FlexboxNode(view: self, hostView: self, textNode: false)
    }
}

typealias DDFlexboxView = UIView & FlexboxView
typealias DDFlexboxTableViewCell = UITableViewCell & FlexboxView
typealias DDFlexboxCollectionViewCell = UICollectionViewCell & FlexboxView
