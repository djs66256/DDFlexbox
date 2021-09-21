//
//  NodeViewController.swift
//  FlexboxSwift
//
//  Created by daniel on 2021/9/21.
//  Copyright © 2021 daniel. All rights reserved.
//

import UIKit

class NodeViewController: UIViewController {
    let nodeView = NodeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        nodeView.backgroundColor = UIColor.red.withAlphaComponent(0.1)
        view.addSubview(nodeView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let size = nodeView.sizeThatFits(CGSize(width: view.frame.width - 20, height: .greatestFiniteMagnitude))
        nodeView.frame = CGRect(x: 10, y: 100, width: view.frame.width - 20, height: size.height)
    }
}

