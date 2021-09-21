//
//  DynamicTableViewCell.swift
//  Example
//
//  Created by daniel on 2021/9/18.
//  Copyright © 2021 daniel. All rights reserved.
//

import Foundation
import DDFlexbox

class TableLikeCell : UITableViewCell, FlexboxView {
    lazy final var flexbox: Flexbox = newFlexbox()

    
    let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.backgroundColor = .red
        return imageView
    }()
    
    let myTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.text = "My title label"
        label.backgroundColor = .gray
        return label
    }()
    
    let myDetailTextLabel: UILabel = {
           let label = UILabel()
           label.font = .systemFont(ofSize: 14)
           label.text = "My detail text label"
           label.backgroundColor = .lightGray
           return label
       }()
    
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
        flexbox.row.padding(10).alignItems(.center).setup({ (b) in
            b.bindView(myImageView).width(40).height(40)
            b.blocker(width: 10)
            b.column.flexGrow(1).flexShrink(1).setup { (b) in
                b.bindView(myTextLabel)
                b.bindView(myDetailTextLabel)
            }
        })
    }
}
