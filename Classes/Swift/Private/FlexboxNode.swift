//
//  FlexboxNode.swift
//  FlexboxSwift
//
//  Created by Daniel on 2021/9/15.
//

import UIKit
import yoga

/// Measure function to calculate view size.
private func FlexboxMeasure(_ node: YGNodeRef?, _ width: Float, _ widthMode: YGMeasureMode, _ height: Float, _ heightMode: YGMeasureMode) -> YGSize {
    let ctx = YGNodeGetContext(node)
    let flex = Unmanaged<FlexboxNode>.fromOpaque(ctx!).takeUnretainedValue()
    let constrainedWidth = (widthMode == .undefined) ? CGFloat.greatestFiniteMagnitude : CGFloat(width)
    let constrainedHeight = (heightMode == .undefined) ? CGFloat.greatestFiniteMagnitude : CGFloat(height)
    var size = CGSize.zero
    if let view = flex.view {
        if !view.isMember(of: UIView.self) {
            size = view.sizeThatFits(CGSize(width: constrainedWidth, height: constrainedHeight))
        }
    }
    return YGSize(width: Float(size.width), height: Float(size.height))
}

class FlexboxNode : Flexbox {
    
    private static let scale = UIScreen.main.scale
    private static let yogaConfig : YGConfigRef = {
        let config = YGConfigNew()!
        YGConfigSetExperimentalFeatureEnabled(config, .webFlexBasis, true)
        YGConfigSetPointScaleFactor(config, Float(scale))
        return config
    }()
    
    #if DEBUG
    private var debugView: UIView?
    #endif
    
    let node: YGNodeRef
    private var textNode = false
    private var needsUpdateLayout = true
    private var oldChildren: [FlexboxNode]?
    weak var view: UIView?
    weak var hostView: FlexboxView?
    
    var children : [FlexboxNode] = [] {
        didSet {
            for child in children {
                child.parent = self
            }
            if isRoot {
                oldChildren = oldValue
            }
        }
    }
    weak var parent : FlexboxNode?
    var root : Flexbox {
        guard let parent = parent else {
            return self
        }
        return parent.root
    }
    
    var isRoot: Bool {
        return parent == nil
    }
    
    var isLeaf: Bool {
        return children.count == 0
    }
    
    deinit {
        YGNodeFree(node)
    }
    
    convenience init() {
        self.init(view: nil, hostView: nil, textNode: false)
    }
    
    convenience init(view: UIView?, textNode: Bool) {
        self.init(view: view, hostView: nil, textNode: textNode)
    }
    
    init(view: UIView?, hostView: FlexboxView?, textNode: Bool) {
        self.node = YGNodeNewWithConfig(Self.yogaConfig)
        YGNodeSetContext(node, Unmanaged.passUnretained(self).toOpaque())
        self.view = view
        self.textNode = textNode
        self.hostView = hostView
        
        #if DEBUG
        if FlexboxDebugEnable {
            // When debug mode, we create a view for virtual node.
            if view == nil {
                debugView = UIView()
                self.view = debugView
                debugView?.layer.borderWidth = 1/Self.scale
                debugView?.layer.borderColor = UIColor.blue.cgColor
            }
        }
        #endif
    }
    
    func prepareForReuse() {
        assert(Thread.isMainThread, "MUST call on main.")
        
        if let parent = YGNodeGetParent(node) {
            YGNodeRemoveChild(parent, node)
        }
    }
    
    func sizeThatFits(_ size: CGSize) -> CGSize {
        assert(Thread.isMainThread, "MUST call on main.")
        
        if isRoot {
            updateFlexboxLayoutIfNeeded(withLayout: false)
            return calculateLayout(contentSize: size)
        }
        return .zero
    }
    
    var intrinsicContentSize: CGSize {
        assert(Thread.isMainThread, "MUST call on main.")
        
        return sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude,
                                   height: CGFloat.greatestFiniteMagnitude))
    }
    
    func layoutSubviews() {
        assert(Thread.isMainThread, "MUST call on main.")
        
        if isRoot, let view = view {
            updateFlexboxLayoutIfNeeded(withLayout: false)
            _ = calculateLayout(contentSize: view.bounds.size)
            
            updateViewHierarchy()
            applyLayoutToViewHierarchy()
        }
    }
    
    func boxRound(_ val: Float) -> CGFloat {
        return CGFloat(round(Double(val)))
    }
    func boxCeil(_ val: Float) -> CGFloat {
        return CGFloat(ceil(Double(val)))
    }
    
    func updateViewHierarchy() {
        assert(Thread.isMainThread, "MUST call on main.")
        assert(isRoot, "MUST update view hierarchy from root node!")
        assert(view != nil, "Root node MUST bind to a view!")
        var oldViews = Set<UIView>()
        if let oldChildren = oldChildren {
            collect(oldViews: &oldViews, nodes: oldChildren)
        }
        if let view = view {
            for child in children {
                child.updateViewHierarchy(superview: view, oldViews: &oldViews)
            }
        }
        for view in oldViews {
            view.removeFromSuperview()
        }
    }
    
    private func collect(oldViews: inout Set<UIView>, nodes: [FlexboxNode]) {
        for child in nodes {
            if let view = child.view {
                oldViews.insert(view)
            }
            collect(oldViews: &oldViews, nodes: child.children)
        }
    }
    
    private func updateViewHierarchy(superview: UIView, oldViews: inout Set<UIView>) {
        assert(Thread.isMainThread, "MUST call on main.")
        
        var nextSuperview = superview
        if let view = view {
            // add to super view
            if view.superview == superview {
                superview.bringSubviewToFront(view)
            }
            else {
                superview.addSubview(view)
            }
            oldViews.remove(view)
            nextSuperview = view
        }
        for child in children {
            child.updateViewHierarchy(superview: nextSuperview, oldViews: &oldViews)
        }
    }
    
    func applyLayoutToViewHierarchy() {
        assert(isRoot)
        for child in children {
            child.applyLayoutToViewHierarchy(origin: .zero)
        }
    }
    
    func applyLayoutToViewHierarchy(origin: CGPoint) {
        assert(Thread.isMainThread, "MUST call on main.")
        
        if let view = view {
            for child in children {
                child.applyLayoutToViewHierarchy(origin: .zero)
            }
            
            let frame = CGRect(x: boxRound(YGNodeLayoutGetLeft(node)) + origin.x,
                               y: boxRound(YGNodeLayoutGetTop(node)) + origin.y,
                               width: boxCeil(YGNodeLayoutGetWidth(node)),
                               height: boxCeil(YGNodeLayoutGetHeight(node)))
            view.frame = frame
        }
        else {
            let newOrigin = CGPoint(x: boxRound(YGNodeLayoutGetLeft(node)) + origin.x,
                                    y: boxRound(YGNodeLayoutGetTop(node)) + origin.y)
            for child in children {
                child.applyLayoutToViewHierarchy(origin: newOrigin)
            }
        }
    }
    
    func updateFlexboxLayout() {
        assert(Thread.isMainThread, "MUST call on main.")
        
        if let hostView = hostView {
            hostView.updateFlexboxLayout()
        }
        for child in children {
            child.updateFlexboxLayout()
        }
    }
    
    func updateYGNodeTree() {
        assert(needsUpdateLayout)
        YGNodeRemoveAllChildren(node)
        for i in  0..<children.count {
            let child = children[i]
            YGNodeInsertChild(node, child.node, UInt32(i))
            child.updateYGNodeTree()
        }
    }
    
    func setupMeasureFunction() {
        if isLeaf && !isRoot {
            YGNodeSetMeasureFunc(node, FlexboxMeasure)
        }
        else {
            YGNodeSetMeasureFunc(node, nil)
            for child in children {
                child.setupMeasureFunction()
            }
        }
    }
    
    func setNeedsUpdateFlexboxLayout() {
        assert(Thread.isMainThread, "MUST call on main.")
        
        if isRoot {
            needsUpdateLayout = true
            view?.setNeedsLayout()
        }
        else {
            root.setNeedsUpdateFlexboxLayout()
        }
    }
    
    func updateFlexboxLayoutIfNeeded() {
        updateFlexboxLayoutIfNeeded(withLayout: true)
    }
    
    func updateFlexboxLayoutIfNeeded(withLayout: Bool) {
        assert(Thread.isMainThread, "MUST call on main.")
        
        if isRoot {
            if needsUpdateLayout {
                updateFlexboxLayout()
                updateYGNodeTree()
                if withLayout {
                    view?.layoutIfNeeded()
                }
                needsUpdateLayout = false
            }
        }
        else {
            (root as! FlexboxNode).updateFlexboxLayoutIfNeeded(withLayout: withLayout)
        }
    }
    
    func calculateLayout(contentSize: CGSize) -> CGSize {
        assert(Thread.isMainThread, "MUST call on main.")
        assert(isRoot, "Flexbox MUST calculate layout from root node!");
        
        setupMeasureFunction()
            
        let width = contentSize.width == CGFloat.greatestFiniteMagnitude
            ? Float.nan : Float(contentSize.width)
        let height = contentSize.height == CGFloat.greatestFiniteMagnitude
            ? Float.nan : Float(contentSize.height)
        
        YGNodeCalculateLayout(node, width, height, YGNodeStyleGetDirection(node))
        
        return CGSize(width: CGFloat(YGNodeLayoutGetWidth(node)),
                      height: CGFloat(YGNodeLayoutGetHeight(node)))
    }
}
