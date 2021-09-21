//
//  ItemsScrollView.swift
//  FlexboxSwift
//
//  Created by daniel on 2021/9/18.
//  Copyright © 2021 daniel. All rights reserved.
//

import UIKit
import DDFlexbox

class ItemsScrollView: UIScrollView, FlexboxView {
    lazy final var flexbox: Flexbox = newFlexbox()
    var itemViews: [UIView] = []
    
    override var frame: CGRect {
        didSet {
            setNeedsUpdateFlexboxLayout()
            let size = flexbox.sizeThatFits(CGSize(width: self.frame.width, height: CGFloat.greatestFiniteMagnitude))
            self.contentSize = size
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        flexbox.layoutSubviews()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return flexbox.sizeThatFits(size)
    }
    
    override var intrinsicContentSize: CGSize {
        return flexbox.intrinsicContentSize
    }
    
    func updateFlexboxLayout() {
        flexbox.row.padding(5).flexWrap(.wrap).setup({ (b) in
            for view in itemViews {
                b.bindView(view).margin(5).width(80).height(80)
            }
        })
    }
    
    func randomComponent() -> CGFloat {
        return CGFloat.random(in: 0...1)
    }
    
    func setupItemViews() {
        for _ in 0..<100 {
            itemViews.append({
                let view = UIView()
                view.layer.cornerRadius = 5
                view.clipsToBounds = true
                view.backgroundColor = UIColor(red: randomComponent(), green: randomComponent(), blue: randomComponent(), alpha: 1)
                return view
            }())
        }
        setNeedsUpdateFlexboxLayout()
        updateFlexboxLayoutIfNeeded()
        let size = flexbox.sizeThatFits(CGSize(width: self.frame.width, height: CGFloat.greatestFiniteMagnitude))
        self.contentSize = size
    }
}
