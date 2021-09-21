//
//  FlexboxStyles.swift
//  FlexboxSwift
//
//  Created by Daniel on 2021/9/15.
//

import UIKit
import yoga

public protocol FlexboxStyles {
    func setup(_ closure: (FlexboxBuilder)->Void)
    
    var row: FlexboxStyles { get }
    var column: FlexboxStyles { get }
    var absolute: FlexboxStyles { get }
    
    
    @discardableResult func direction(_ value: YGDirection) -> FlexboxStyles
    @discardableResult func flexDirection(_ value: YGFlexDirection) -> FlexboxStyles
    @discardableResult func justifyContent(_ value: YGJustify) -> FlexboxStyles
    @discardableResult func alignContent(_ value: YGAlign) -> FlexboxStyles
    @discardableResult func alignItems(_ value: YGAlign) -> FlexboxStyles
    @discardableResult func alignSelf(_ value: YGAlign) -> FlexboxStyles
    
    @discardableResult func position(_ value: YGPositionType) -> FlexboxStyles
    @discardableResult func flexWrap(_ value: YGWrap) -> FlexboxStyles
    @discardableResult func overflow(_ value: YGOverflow) -> FlexboxStyles
    @discardableResult func display(_ value: YGDisplay) -> FlexboxStyles
    
    @discardableResult func flex(_ value: CGFloat) -> FlexboxStyles
    @discardableResult func flexGrow(_ value: CGFloat) -> FlexboxStyles
    @discardableResult func flexShrink(_ value: CGFloat) -> FlexboxStyles
    @discardableResult func flexBasis(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func flexBasis(_ value: CGFloat?) -> FlexboxStyles
    
    @discardableResult func left(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func left(_ value: CGFloat) -> FlexboxStyles
    @discardableResult func top(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func top(_ value: CGFloat) -> FlexboxStyles
    @discardableResult func right(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func right(_ value: CGFloat) -> FlexboxStyles
    @discardableResult func bottom(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func bottom(_ value: CGFloat) -> FlexboxStyles
    @discardableResult func start(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func start(_ value: CGFloat) -> FlexboxStyles
    @discardableResult func end(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func end(_ value: CGFloat) -> FlexboxStyles
    
    @discardableResult func marginLeft(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func marginLeft(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func marginTop(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func marginTop(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func marginRight(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func marginRight(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func marginBottom(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func marginBottom(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func marginStart(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func marginStart(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func marginEnd(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func marginEnd(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func marginHorizontal(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func marginHorizontal(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func marginVertical(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func marginVertical(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func margin(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func margin(_ value: CGFloat?) -> FlexboxStyles
    
    @discardableResult func paddingLeft(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func paddingLeft(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func paddingTop(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func paddingTop(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func paddingRight(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func paddingRight(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func paddingBottom(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func paddingBottom(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func paddingStart(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func paddingStart(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func paddingEnd(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func paddingEnd(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func paddingHorizontal(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func paddingHorizontal(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func paddingVertical(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func paddingVertical(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func padding(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func padding(_ value: CGFloat?) -> FlexboxStyles
    
    @discardableResult func width(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func width(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func height(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func height(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func minWidth(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func minWidth(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func minHeight(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func minHeight(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func maxWidth(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func maxWidth(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func maxHeight(_ value: FlexboxPercent) -> FlexboxStyles
    @discardableResult func maxHeight(_ value: CGFloat?) -> FlexboxStyles
    
    @discardableResult func aspectRatio(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func borderLeftWidth(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func borderTopWidth(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func borderRightWidth(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func borderBottomWidth(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func borderStartWidth(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func borderEndWidth(_ value: CGFloat?) -> FlexboxStyles
    @discardableResult func borderWidth(_ value: CGFloat?) -> FlexboxStyles
}

public protocol FlexboxBuilder {
    var row: FlexboxStyles { get }
    var column: FlexboxStyles { get }
    var absolute: FlexboxStyles { get }
    
    /// Create a node bind to a UIView.
    /// - Parameter view: View in node tree. When it is FlexboxView, will call connect().
    @discardableResult func bindView(_ view: UIView) -> FlexboxStyles
    
    /// Combine to another FlexboxView. It will not create a new node.
    /// - Parameter view: FlexboxView to connected. It can be AnyObject.
    @discardableResult func connect(_ view: FlexboxView) -> FlexboxStyles
    
    /// Create a spacer, which `flexGrow = 1` and `flexShrink = 1`.
    @discardableResult func spacer() -> FlexboxStyles
    /// Create a blocker, which `width = width`.
    @discardableResult func blocker(width: CGFloat) -> FlexboxStyles
    /// Create a blocker, which `height = height`.
    @discardableResult func blocker(height: CGFloat) -> FlexboxStyles
    /// Create a blocker, which `width = width` and `height = height`.
    @discardableResult func blocker(width: CGFloat, height: CGFloat) -> FlexboxStyles
    
    /// Helper functions.
    func `if`(_ condition: Bool) -> FlexboxBuilder?
    func ifNot(_ condition: Bool) -> FlexboxBuilder?
    func ifExists(_ obj: Any?) -> FlexboxBuilder?
    func ifNotEmpty<T>(_ collection: Array<T>?) -> FlexboxBuilder?
    func ifNotEmpty<T>(_ collection: Set<T>?) -> FlexboxBuilder? where T : Hashable
    func ifNotEmpty<T>(_ collection: Dictionary<T, Any>?) -> FlexboxBuilder? where T : Hashable
    
    /// Use key to store the flexbox. It will not create a new one if exists.
    /// The key MUST be unique.
    /// - Parameter key: A key to store the flexbox
    func key(_ key: FlexboxKey) -> FlexboxBuilder
}
