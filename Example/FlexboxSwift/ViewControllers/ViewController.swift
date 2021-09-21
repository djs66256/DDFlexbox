//
//  ViewController.swift
//  Example
//
//  Created by daniel on 2021/9/12.
//  Copyright © 2021 daniel. All rights reserved.
//

import UIKit
import DDFlexbox

class ViewController: UITableViewController {
    
    let dataSource = [
        ["class": FlexboxTableViewController.self, "name": "Flexbox in table cell"],
        ["class": DynamicTableViewController.self, "name": "Flexbox in dynamic data table cell"],
        ["class": ItemScrollViewController.self, "name": "Flexbox in scrollView"],
        ["class": ShareEventViewViewController.self, "name": "Event cell in flexbox with subviews"],
        ["class": NodeViewController.self, "name": "Flexbox work with node"],
        ["class": WorkWithAutoLayoutViewController.self, "name": "Flexbox work with AutoLayout"],
        ["class": AnimationViewController.self, "name": "Flexbox work with animations"],
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "debug", style: .plain, target: self, action: #selector(debugSwitch(sender:)))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = (dataSource[indexPath.row]["name"] as! String)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cls = dataSource[indexPath.row]["class"] as! UIViewController.Type
        let vc = cls.init()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func debugSwitch(sender: Any) {
        FlexboxDebugEnable = !FlexboxDebugEnable
    }
}

