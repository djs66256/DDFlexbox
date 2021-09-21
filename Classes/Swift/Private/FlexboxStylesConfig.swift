//
//  FlexboxStylesConfig.swift
//  FlexboxSwift
//
//  Created by Daniel on 2021/9/15.
//

import Foundation
import yoga

extension FlexboxBuilder {
    
    func `if`(_ condition: Bool) -> FlexboxBuilder? {
        if condition {
            return self
        }
        return nil
    }
    
    func ifNot(_ condition: Bool) -> FlexboxBuilder? {
        return `if`(!condition)
    }
    
    func ifExists(_ obj: Any?) -> FlexboxBuilder? {
        return `if`(obj != nil)
    }
    
    func ifNotEmpty<T>(_ collection: Array<T>?) -> FlexboxBuilder? {
        return `if`(collection != nil && !collection!.isEmpty)
    }
    
    func ifNotEmpty<T>(_ collection: Set<T>?) -> FlexboxBuilder? where T : Hashable {
        return `if`(collection != nil && !collection!.isEmpty)
    }
    
    func ifNotEmpty<T>(_ collection: Dictionary<T, Any>?) -> FlexboxBuilder? where T : Hashable {
        return `if`(collection != nil && !collection!.isEmpty)
    }
    
}

class FlexboxNodeBuilder : FlexboxBuilder {
    
    private let flexbox : FlexboxNode
    private var children : [FlexboxNode] = []
    
    init(flexbox: FlexboxNode) {
        self.flexbox = flexbox
    }
    
    func adopt(child: FlexboxNode) {
        children.append(child)
    }
    
    var row: FlexboxStyles {
        let node = FlexboxNode()
        adopt(child: node)
        return node.row
    }
    
    var column: FlexboxStyles {
        let node = FlexboxNode()
        adopt(child: node)
        return node.column
    }
    
    var absolute: FlexboxStyles {
        let node = FlexboxNode()
        adopt(child: node)
        return node.column
    }
    
    func bindView(_ view: UIView) -> FlexboxStyles {
        if let view = view as? FlexboxView {
            return connect(view)
        }
        else {
            let node = FlexboxNode(view: view, hostView: nil, textNode: view is UILabel)
            adopt(child: node)
            return node
        }
    }
    
    func connect(_ view: FlexboxView) -> FlexboxStyles {
        return reuse(flexbox: view.flexbox)
    }
    
    func spacer() -> FlexboxStyles {
        let node = FlexboxNode()
        adopt(child: node)
        return node.flex(1)
    }
    
    func blocker(width: CGFloat) -> FlexboxStyles {
        let node = FlexboxNode()
        adopt(child: node)
        return node.width(width)
    }
    
    func blocker(height: CGFloat) -> FlexboxStyles {
        let node = FlexboxNode()
        adopt(child: node)
        return node.height(height)
    }
    
    func blocker(width: CGFloat, height: CGFloat) -> FlexboxStyles {
        let node = FlexboxNode()
        adopt(child: node)
        return node.width(width).height(height)
    }
    
    func key(_ key: FlexboxKey) -> FlexboxBuilder {
        return KeyedFlexboxNodeBuilder(key: key, builder: self)
    }
    
    func reuse(flexbox: Flexbox) -> FlexboxStyles {
        let node = flexbox as! FlexboxNode
        node.prepareForReuse()
        adopt(child: node)
        return node
    }
    
    func commit() {
        self.flexbox.children = children
    }
}

class KeyedFlexboxNodeBuilder: FlexboxBuilder {
    var key: FlexboxKey
    let builder: FlexboxNodeBuilder
    
    init(key: FlexboxKey, builder: FlexboxNodeBuilder) {
        self.key = key
        self.builder = builder
    }
    
    var row: FlexboxStyles {
        if let flexbox = key.flexbox {
            return builder.reuse(flexbox: flexbox)
        }
        else {
            let node = builder.row as! FlexboxNode
            key.flexbox = node
            return node
        }
    }

    var column: FlexboxStyles {
        if let flexbox = key.flexbox {
            return builder.reuse(flexbox: flexbox)
        }
        else {
            let node = builder.column as! FlexboxNode
            key.flexbox = node
            return node
        }
    }

    var absolute: FlexboxStyles {
        if let flexbox = key.flexbox {
            return builder.reuse(flexbox: flexbox)
        }
        else {
            let node = builder.absolute as! FlexboxNode
            key.flexbox = node
            return node
        }
    }

    func bindView(_ view: UIView) -> FlexboxStyles {
        if let flexbox = key.flexbox {
            return builder.reuse(flexbox: flexbox)
        }
        else {
            let node = builder.bindView(view) as! FlexboxNode
            key.flexbox = node
            return node
        }
    }

    func connect(_ view: FlexboxView) -> FlexboxStyles {
        if let flexbox = key.flexbox {
            return builder.reuse(flexbox: flexbox)
        }
        else {
            let node = builder.connect(view) as! FlexboxNode
            key.flexbox = node
            return node
        }
    }
    
    func spacer() -> FlexboxStyles {
        if let flexbox = key.flexbox {
            return builder.reuse(flexbox: flexbox)
        }
        else {
            let node = builder.spacer() as! FlexboxNode
            key.flexbox = node
            return node
        }
    }
    
    func blocker(width: CGFloat) -> FlexboxStyles {
        if let flexbox = key.flexbox {
            return builder.reuse(flexbox: flexbox)
        }
        else {
            let node = builder.blocker(width: width) as! FlexboxNode
            key.flexbox = node
            return node
        }
    }
    
    func blocker(height: CGFloat) -> FlexboxStyles {
        if let flexbox = key.flexbox {
            return builder.reuse(flexbox: flexbox)
        }
        else {
            let node = builder.blocker(height: height) as! FlexboxNode
            key.flexbox = node
            return node
        }
    }
    
    func blocker(width: CGFloat, height: CGFloat) -> FlexboxStyles {
        if let flexbox = key.flexbox {
            return builder.reuse(flexbox: flexbox)
        }
        else {
            let node = builder.blocker(width: width, height: height) as! FlexboxNode
            key.flexbox = node
            return node
        }
    }

    func key(_ key: FlexboxKey) -> FlexboxBuilder {
        return KeyedFlexboxNodeBuilder(key: key, builder: builder)
    }
}
