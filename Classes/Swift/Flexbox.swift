//
//  Flexbox.swift
//  FlexboxSwift
//
//  Created by Daniel on 2021/9/15.
//

import UIKit
import yoga

#if DEBUG
public var FlexboxDebugEnable : Bool = false
#endif

public protocol Flexbox : AnyObject, FlexboxStyles {
    var root : Flexbox { get }
    var isRoot: Bool { get }
    
    var intrinsicContentSize: CGSize { get }
    func sizeThatFits(_ size: CGSize) -> CGSize
    
    /// Combine UIView and flexbox node.
    /// MUST call in the UIView.layoutSubviews()
    func layoutSubviews()
    
    /// You must define flexbox layout in this method.
    func updateFlexboxLayout()
    
    /// When layout should change, mark it should update.
    /// It will update when next layoutSubviews().
    func setNeedsUpdateFlexboxLayout()
    
    /// Force update flexbox layout, and call layoutIfNeeded() immediately.
    func updateFlexboxLayoutIfNeeded()
}
