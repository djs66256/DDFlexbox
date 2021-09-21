//
//  ViewController.swift
//  Example
//
//  Created by daniel on 2021/9/12.
//  Copyright © 2021 daniel. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let dataSource = [
        ["class": FlexboxTableViewController.self, "name": "Flexbox in table cell"],
        ["class": DynamicTableViewController.self, "name": "Flexbox in dynamic data table cell"],
        ["class": ItemScrollViewController.self, "name": "Flexbox in scrollView"],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
}

