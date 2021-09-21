//
//  SubCardView.swift
//  Example
//
//  Created by daniel on 2021/9/18.
//  Copyright © 2021 daniel. All rights reserved.
//

import UIKit
import DDFlexbox

class SubCardView : UIView, FlexboxView {
    lazy final var flexbox: Flexbox = newFlexbox()
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    let backgroundView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
    }
    
    func configUI() {
        backgroundView.layer.cornerRadius = 5
        backgroundView.clipsToBounds = true
        backgroundView.backgroundColor = UIColor(white: 0, alpha: 0.1)
        
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        
        titleLabel.text = "亲爱的你怎么不在我身边"
        
        detailLabel.font = UIFont.systemFont(ofSize: 12)
        detailLabel.text = "江美琪"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        flexbox.row.padding(5).setup({ (b) in
            b.bindView(backgroundView).absolute.left(0).right(0).top(0).bottom(0)
            b.bindView(imageView).width(40).height(40)
            b.blocker(width: 5)
            b.column.flexGrow(1).flexShrink(1).setup { (b) in
                b.bindView(titleLabel)
                b.blocker(height: 2)
                b.bindView(detailLabel)
            }
        })
    }
}
