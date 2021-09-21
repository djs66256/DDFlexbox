//
//  WorkWithAutoLayoutViewController.swift
//  FlexboxSwift
//
//  Created by daniel on 2021/9/21.
//  Copyright © 2021 daniel. All rights reserved.
//

import Foundation
import UIKit

class WorkWithAutoLayoutViewController: UIViewController {
    let flexWithAutoLayoutLabel = UILabel()
    let flexWithAutoLayoutView = FlexboxSuperview()
    let autoLayoutWithFlexLabel = UILabel()
    let autoLayoutWithFlexView = AutoLayoutSuperview(frame: CGRect(origin: .zero, size: CGSize(width: 400, height: 50)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        flexWithAutoLayoutLabel.text = "flexbox superview with autolayout subview:"
        view.addSubview(flexWithAutoLayoutLabel)
        view.addSubview(flexWithAutoLayoutView)
        
        autoLayoutWithFlexLabel.text = "autolayout superview with flexbox subview:"
        view.addSubview(autoLayoutWithFlexLabel)
        view.addSubview(autoLayoutWithFlexView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        flexWithAutoLayoutLabel.frame = CGRect(x: 10, y: 100, width: view.frame.width - 20, height: 20)
        
        let size1 = flexWithAutoLayoutView.sizeThatFits(CGSize(width: view.frame.width - 20, height: .greatestFiniteMagnitude))
        flexWithAutoLayoutView.frame = CGRect(x: 10, y: 150, width: size1.width, height: size1.height)
        
        autoLayoutWithFlexLabel.frame = CGRect(x: 10, y: 250, width: view.frame.width - 20, height: 20)
        
        let size2 = autoLayoutWithFlexView.systemLayoutSizeFitting(CGSize(width: view.frame.width - 20, height: .greatestFiniteMagnitude))
        autoLayoutWithFlexView.frame = CGRect(x: 10, y: 300, width: view.frame.width - 20, height: size2.height)
    }
}
