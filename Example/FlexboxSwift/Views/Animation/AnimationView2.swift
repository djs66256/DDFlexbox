//
//  AnimationView2.swift
//  Example
//
//  Created by daniel on 2021/9/21.
//  Copyright © 2021 daniel. All rights reserved.
//

import UIKit
import DDFlexbox

class AnimationView2 : UIView, FlexboxView {
    lazy final var flexbox: Flexbox = newFlexbox()
    
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    var alignLeft = true {
        didSet {
            setNeedsUpdateFlexboxLayout()
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
        flexbox.row.alignItems(.center).justifyContent(alignLeft ? .flexStart : .flexEnd).setup { (b) in
            b.bindView(view).width(40).height(40)
        }
    }
}
