//
//  ItemScrollViewController.swift
//  Example
//
//  Created by daniel on 2021/9/15.
//  Copyright © 2021 daniel. All rights reserved.
//

import Foundation

class ItemScrollViewController: UIViewController {
    let scrollView = DDItemsScrollView()
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.setupItemViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        scrollView.frame = self.view.bounds;
    }
}
