//
//  Percent.swift
//  FlexboxSwift
//
//  Created by Daniel on 2021/9/15.
//

import UIKit

public struct FlexboxPercent {
    let value: CGFloat
}

postfix operator %
public postfix func % (v: CGFloat) -> FlexboxPercent {
    return FlexboxPercent(value: v)
}

public postfix func % (v: Int) -> FlexboxPercent {
    return FlexboxPercent(value: CGFloat(v))
}

prefix operator -
public prefix func - (p: FlexboxPercent) -> FlexboxPercent {
    return FlexboxPercent(value: -p.value)
}
