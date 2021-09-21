//
//  FlexboxNode+FlexboxStyles.swift
//  DDFlexbox
//
//  Created by daniel on 2021/9/21.
//

import Foundation
import yoga

extension FlexboxNode : FlexboxStyles {
    
    var row: FlexboxStyles {
        return flexDirection(.row)
    }
    
    var column: FlexboxStyles {
        return flexDirection(.column)
    }
    
    var absolute: FlexboxStyles {
        return position(.absolute)
    }
    
    func direction(_ value: YGDirection) -> FlexboxStyles {
        YGNodeStyleSetDirection(node, value)
        return self
    }
    
    func flexDirection(_ value: YGFlexDirection) -> FlexboxStyles {
        YGNodeStyleSetFlexDirection(node, value)
        return self
    }
    
    func justifyContent(_ value: YGJustify) -> FlexboxStyles {
        YGNodeStyleSetJustifyContent(node, value)
        return self
    }
    
    func alignContent(_ value: YGAlign) -> FlexboxStyles {
        YGNodeStyleSetAlignContent(node, value)
        return self
    }
    
    func alignItems(_ value: YGAlign) -> FlexboxStyles {
        YGNodeStyleSetAlignItems(node, value)
        return self
    }
    
    func alignSelf(_ value: YGAlign) -> FlexboxStyles {
        YGNodeStyleSetAlignSelf(node, value)
        return self
    }
    
    func position(_ value: YGPositionType) -> FlexboxStyles {
        YGNodeStyleSetPositionType(node, value)
        return self
    }
    
    func flexWrap(_ value: YGWrap) -> FlexboxStyles {
        YGNodeStyleSetFlexWrap(node, value)
        return self
    }
    
    func overflow(_ value: YGOverflow) -> FlexboxStyles {
        YGNodeStyleSetOverflow(node, value)
        return self
    }
    
    func display(_ value: YGDisplay) -> FlexboxStyles {
        YGNodeStyleSetDisplay(node, value)
        return self
    }
    
    func flex(_ value: CGFloat) -> FlexboxStyles {
        YGNodeStyleSetFlex(node, Float(value))
        return self
    }
    
    func flexGrow(_ value: CGFloat) -> FlexboxStyles {
        YGNodeStyleSetFlexGrow(node, Float(value))
        return self
    }
    
    func flexShrink(_ value: CGFloat) -> FlexboxStyles {
        YGNodeStyleSetFlexShrink(node, Float(value))
        return self
    }
    
    private func flexboxValue(_ value: FlexboxPercent) -> YGValue {
        return YGValue(value: Float(value.value), unit: .percent)
    }
    private func flexboxValue(_ value: CGFloat?) -> YGValue {
        if let value = value {
            return YGValue(value: Float(value), unit: .point)
        }
        else {
            return YGValue(value: 0, unit: .undefined)
        }
    }
    
    func flexBasis(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetFlexBasisPercent(node, Float(value.value))
        return self
    }
    
    func flexBasis(_ value: CGFloat?) -> FlexboxStyles {
        if let value = value {
            YGNodeStyleSetFlexBasis(node, Float(value))
        }
        else {
            YGNodeStyleSetFlexBasisAuto(node)
        }
        return self
    }
    
    func left(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetPositionPercent(node, .left, Float(value.value))
        return self
    }
    
    func left(_ value: CGFloat) -> FlexboxStyles {
        YGNodeStyleSetPosition(node, .left, Float(value))
        return self
    }
    
    func top(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetPositionPercent(node, .top, Float(value.value))
        return self
    }
    
    func top(_ value: CGFloat) -> FlexboxStyles {
        YGNodeStyleSetPosition(node, .top, Float(value))
        return self
    }
    
    func right(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetPositionPercent(node, .right, Float(value.value))
        return self
    }
    
    func right(_ value: CGFloat) -> FlexboxStyles {
        YGNodeStyleSetPosition(node, .right, Float(value))
        return self
    }
    
    func bottom(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetPositionPercent(node, .bottom, Float(value.value))
        return self
    }
    
    func bottom(_ value: CGFloat) -> FlexboxStyles {
        YGNodeStyleSetPosition(node, .bottom, Float(value))
        return self
    }
    
    func start(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetPositionPercent(node, .start, Float(value.value))
        return self
    }
    
    func start(_ value: CGFloat) -> FlexboxStyles {
        YGNodeStyleSetPosition(node, .start, Float(value))
        return self
    }
    
    func end(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetPositionPercent(node, .end, Float(value.value))
        return self
    }
    
    func end(_ value: CGFloat) -> FlexboxStyles {
        YGNodeStyleSetPosition(node, .end, Float(value))
        return self
    }
    
    func marginLeft(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetMarginPercent(node, .left, Float(value.value))
        return self
    }
    
    func marginLeft(_ value: CGFloat?) -> FlexboxStyles {
        if let value = value {
            YGNodeStyleSetMargin(node, .left, Float(value))
        }
        else {
            YGNodeStyleSetMarginAuto(node, .left)
        }
        return self
    }
    
    func marginTop(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetMarginPercent(node, .top, Float(value.value))
        return self
    }
    
    func marginTop(_ value: CGFloat?) -> FlexboxStyles {
        if let value = value {
            YGNodeStyleSetMargin(node, .top, Float(value))
        }
        else {
            YGNodeStyleSetMarginAuto(node, .top)
        }
        return self
    }
    
    func marginRight(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetMarginPercent(node, .right, Float(value.value))
        return self
    }
    
    func marginRight(_ value: CGFloat?) -> FlexboxStyles {
        if let value = value {
            YGNodeStyleSetMargin(node, .right, Float(value))
        }
        else {
            YGNodeStyleSetMarginAuto(node, .right)
        }
        return self
    }
    
    func marginBottom(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetMarginPercent(node, .bottom, Float(value.value))
        return self
    }
    
    func marginBottom(_ value: CGFloat?) -> FlexboxStyles {
        if let value = value {
            YGNodeStyleSetMargin(node, .bottom, Float(value))
        }
        else {
            YGNodeStyleSetMarginAuto(node, .bottom)
        }
        return self
    }
    
    func marginStart(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetMarginPercent(node, .start, Float(value.value))
        return self
    }
    
    func marginStart(_ value: CGFloat?) -> FlexboxStyles {
        if let value = value {
            YGNodeStyleSetMargin(node, .start, Float(value))
        }
        else {
            YGNodeStyleSetMarginAuto(node, .start)
        }
        return self
    }
    
    func marginEnd(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetMarginPercent(node, .end, Float(value.value))
        return self
    }
    
    func marginEnd(_ value: CGFloat?) -> FlexboxStyles {
        if let value = value {
            YGNodeStyleSetMargin(node, .end, Float(value))
        }
        else {
            YGNodeStyleSetMarginAuto(node, .end)
        }
        return self
    }
    
    func marginHorizontal(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetMarginPercent(node, .horizontal, Float(value.value))
        return self
    }
    
    func marginHorizontal(_ value: CGFloat?) -> FlexboxStyles {
        if let value = value {
            YGNodeStyleSetMargin(node, .horizontal, Float(value))
        }
        else {
            YGNodeStyleSetMarginAuto(node, .horizontal)
        }
        return self
    }
    
    func marginVertical(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetMarginPercent(node, .vertical, Float(value.value))
        return self
    }
    
    func marginVertical(_ value: CGFloat?) -> FlexboxStyles {
        if let value = value {
            YGNodeStyleSetMargin(node, .vertical, Float(value))
        }
        else {
            YGNodeStyleSetMarginAuto(node, .vertical)
        }
        return self
    }
    
    func margin(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetMarginPercent(node, .all, Float(value.value))
        return self
    }
    
    func margin(_ value: CGFloat?) -> FlexboxStyles {
        if let value = value {
            YGNodeStyleSetMargin(node, .all, Float(value))
        }
        else {
            YGNodeStyleSetMarginAuto(node, .all)
        }
        return self
    }
    
    func paddingLeft(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetPaddingPercent(node, .left, Float(value.value))
        return self
    }
    
    func paddingLeft(_ value: CGFloat?) -> FlexboxStyles {
        if let value = value {
            YGNodeStyleSetPadding(node, .left, Float(value))
        }
        else {
            YGNodeStyleSetPadding(node, .left, 0)
        }
        return self
    }
    
    func paddingTop(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetPaddingPercent(node, .top, Float(value.value))
        return self
    }
    
    func paddingTop(_ value: CGFloat?) -> FlexboxStyles {
        if let value = value {
            YGNodeStyleSetPadding(node, .top, Float(value))
        }
        else {
            YGNodeStyleSetPadding(node, .top, 0)
        }
        return self
    }
    
    func paddingRight(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetPaddingPercent(node, .right, Float(value.value))
        return self
    }
    
    func paddingRight(_ value: CGFloat?) -> FlexboxStyles {
        if let value = value {
            YGNodeStyleSetPadding(node, .right, Float(value))
        }
        else {
            YGNodeStyleSetPadding(node, .right, 0)
        }
        return self
    }
    
    func paddingBottom(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetPaddingPercent(node, .bottom, Float(value.value))
        return self
    }
    
    func paddingBottom(_ value: CGFloat?) -> FlexboxStyles {
        if let value = value {
            YGNodeStyleSetPadding(node, .bottom, Float(value))
        }
        else {
            YGNodeStyleSetPadding(node, .bottom, 0)
        }
        return self
    }
    
    func paddingStart(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetPaddingPercent(node, .start, Float(value.value))
        return self
    }
    
    func paddingStart(_ value: CGFloat?) -> FlexboxStyles {
        if let value = value {
            YGNodeStyleSetPadding(node, .start, Float(value))
        }
        else {
            YGNodeStyleSetPadding(node, .start, 0)
        }
        return self
    }
    
    func paddingEnd(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetPaddingPercent(node, .end, Float(value.value))
        return self
    }
    
    func paddingEnd(_ value: CGFloat?) -> FlexboxStyles {
        if let value = value {
            YGNodeStyleSetPadding(node, .end, Float(value))
        }
        else {
            YGNodeStyleSetPadding(node, .end, 0)
        }
        return self
    }
    
    func paddingHorizontal(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetPaddingPercent(node, .horizontal, Float(value.value))
        return self
    }
    
    func paddingHorizontal(_ value: CGFloat?) -> FlexboxStyles {
        if let value = value {
            YGNodeStyleSetPadding(node, .horizontal, Float(value))
        }
        else {
            YGNodeStyleSetPadding(node, .horizontal, 0)
        }
        return self
    }
    
    func paddingVertical(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetPaddingPercent(node, .vertical, Float(value.value))
        return self
    }
    
    func paddingVertical(_ value: CGFloat?) -> FlexboxStyles {
        if let value = value {
            YGNodeStyleSetPadding(node, .vertical, Float(value))
        }
        else {
            YGNodeStyleSetPadding(node, .vertical, 0)
        }
        return self
    }
    
    func padding(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetPaddingPercent(node, .all, Float(value.value))
        return self
    }
    
    func padding(_ value: CGFloat?) -> FlexboxStyles {
        if let value = value {
            YGNodeStyleSetPadding(node, .all, Float(value))
        }
        else {
            YGNodeStyleSetPadding(node, .all, 0)
        }
        return self
    }
    
    func width(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetWidthPercent(node, Float(value.value))
        return self
    }
    
    func width(_ value: CGFloat?) -> FlexboxStyles {
        if let value = value {
            YGNodeStyleSetWidth(node, Float(value))
        }
        else {
            YGNodeStyleSetWidthAuto(node)
        }
        return self
    }
    
    func height(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetHeightPercent(node, Float(value.value))
        return self
    }
    
    func height(_ value: CGFloat?) -> FlexboxStyles {
        if let value = value {
            YGNodeStyleSetHeight(node, Float(value))
        }
        else {
            YGNodeStyleSetHeightAuto(node)
        }
        return self
    }
    
    func minWidth(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetMinWidthPercent(node, Float(value.value))
        return self
    }
    
    func minWidth(_ value: CGFloat?) -> FlexboxStyles {
        if let value = value {
            YGNodeStyleSetMinWidth(node, Float(value))
        }
        else {
            YGNodeStyleSetMinWidth(node, 0)
        }
        return self
    }
    
    func minHeight(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetMinHeightPercent(node, Float(value.value))
        return self
    }
    
    func minHeight(_ value: CGFloat?) -> FlexboxStyles {
        if let value = value {
            YGNodeStyleSetMinHeight(node, Float(value))
        }
        else {
            YGNodeStyleSetMinHeight(node, 0)
        }
        return self
    }
    
    func maxWidth(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetMaxWidthPercent(node, Float(value.value))
        return self
    }
    
    func maxWidth(_ value: CGFloat?) -> FlexboxStyles {
        if let value = value {
            YGNodeStyleSetMaxWidth(node, Float(value))
        }
        else {
            YGNodeStyleSetMaxWidth(node, Float.greatestFiniteMagnitude)
        }
        return self
    }
    
    func maxHeight(_ value: FlexboxPercent) -> FlexboxStyles {
        YGNodeStyleSetMaxHeightPercent(node, Float(value.value))
        return self
    }
    
    func maxHeight(_ value: CGFloat?) -> FlexboxStyles {
        if let value = value {
            YGNodeStyleSetMaxHeight(node, Float(value))
        }
        else {
            YGNodeStyleSetMaxHeight(node, Float.greatestFiniteMagnitude)
        }
        return self
    }
    
    func aspectRatio(_ value: CGFloat?) -> FlexboxStyles {
        YGNodeStyleSetAspectRatio(node, value == nil ? 0 : Float(value!))
        return self
    }
    
    func borderLeftWidth(_ value: CGFloat?) -> FlexboxStyles {
        YGNodeStyleSetBorder(node, .left, value == nil ? 0 : Float(value!))
        return self
    }
    
    func borderTopWidth(_ value: CGFloat?) -> FlexboxStyles {
        YGNodeStyleSetBorder(node, .top, value == nil ? 0 : Float(value!))
        return self
    }
    
    func borderRightWidth(_ value: CGFloat?) -> FlexboxStyles {
        YGNodeStyleSetBorder(node, .right, value == nil ? 0 : Float(value!))
        return self
    }
    
    func borderBottomWidth(_ value: CGFloat?) -> FlexboxStyles {
        YGNodeStyleSetBorder(node, .bottom, value == nil ? 0 : Float(value!))
        return self
    }
    
    func borderStartWidth(_ value: CGFloat?) -> FlexboxStyles {
        YGNodeStyleSetBorder(node, .start, value == nil ? 0 : Float(value!))
        return self
    }
    
    func borderEndWidth(_ value: CGFloat?) -> FlexboxStyles {
        YGNodeStyleSetBorder(node, .end, value == nil ? 0 : Float(value!))
        return self
    }
    
    func borderWidth(_ value: CGFloat?) -> FlexboxStyles {
        YGNodeStyleSetBorder(node, .all, value == nil ? 0 : Float(value!))
        return self
    }
    
    
    func setup(_ closure: (FlexboxBuilder)->Void) {
        let builder = FlexboxNodeBuilder(flexbox: self)
        closure(builder)
        builder.commit()
    }
    
}
