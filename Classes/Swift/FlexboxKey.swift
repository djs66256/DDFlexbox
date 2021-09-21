//
//  FlexboxKey.swift
//  DDFlexbox
//
//  Created by daniel on 2021/9/21.
//

import Foundation

public protocol FlexboxKey {
    var flexbox: Flexbox? { get set }
}

private struct FlexboxUniqueKey : FlexboxKey {
    var flexbox: Flexbox?
}

public class FlexboxUniqueKeys {
    private var keys: [String: FlexboxKey] = [:]
    
    public init() { }
    
    public func make(_ str: String) -> FlexboxKey {
        if let key = keys[str] {
            return key
        }
        else {
            let key = FlexboxUniqueKey()
            keys[str] = key
            return key
        }
    }
}
