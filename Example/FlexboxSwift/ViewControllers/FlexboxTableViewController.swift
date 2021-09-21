//
//  File.swift
//  Example
//
//  Created by daniel on 2021/9/15.
//  Copyright © 2021 daniel. All rights reserved.
//

import Foundation
import UIKit
import DDFlexbox

typealias FlexboxTableViewCell = UITableViewCell & FlexboxView

class FlexboxTableViewController : UITableViewController {
    var cellClasses: [FlexboxTableViewCell.Type] = []
    
    init() {
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellClasses = [TableLikeCell.self]
        
        for cls in cellClasses {
            self.tableView.register(cls, forCellReuseIdentifier: String(reflecting: cls))
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellClasses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(reflecting: cellClasses[indexPath.row])) as! FlexboxTableViewCell
        cell.setNeedsUpdateFlexboxLayout()
        cell.updateFlexboxLayoutIfNeeded()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(reflecting: cellClasses[indexPath.row])) as! FlexboxTableViewCell
        cell.setNeedsUpdateFlexboxLayout()
        cell.updateFlexboxLayoutIfNeeded()
        let size = cell.sizeThatFits(CGSize(width: tableView.frame.width, height: CGFloat.greatestFiniteMagnitude))
        return size.height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
