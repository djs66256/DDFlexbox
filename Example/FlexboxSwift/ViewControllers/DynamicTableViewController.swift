//
//  DynamicTableViewController.swift
//  Example
//
//  Created by daniel on 2021/9/15.
//  Copyright © 2021 daniel. All rights reserved.
//

import UIKit


class DynamicTableViewController : UITableViewController {
    
    var datas : [DynamicTableCellModel] = []
    var cursor = 0
    
    init() {
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "switch", style: .plain, target: self, action: #selector(next(sender:)))
        
        datas = [
            buildModel(image: UIImage(), text: nil, detailText: nil),
            buildModel(image: UIImage(), text: "My text label", detailText: nil),
            buildModel(image: UIImage(), text: nil, detailText: "My detail text label"),
            buildModel(image: nil, text: "My text label", detailText: nil),
            buildModel(image: nil, text: nil, detailText: "My detail text label"),
            buildModel(image: nil, text: "My text label", detailText: "My detail text label"),
            buildModel(image: UIImage(), text: "My text label", detailText: "My detail text label"),
        ]
        
        self.tableView.allowsSelection = false;
        self.tableView.register(DynamicTableCell.self, forCellReuseIdentifier: "cell")
    }
    
    func buildModel(image: UIImage?, text: String?, detailText: String?) -> DynamicTableCellModel {
        let model = DynamicTableCellModel()
        model.image = image
        model.title = text
        model.detailText = detailText
        return model
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DynamicTableCell
        if indexPath.row < datas.count {
            cell.model = datas[indexPath.row]
        }
        else {
            cell.model = datas[cursor]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DynamicTableCell
        if indexPath.row < datas.count {
            cell.model = datas[indexPath.row]
        }
        else {
            cell.model = datas[cursor]
        }
        let size = cell.sizeThatFits(CGSize(width: tableView.frame.width, height: CGFloat.greatestFiniteMagnitude))
        return size.height
    }
    
    @objc
    func next(sender: Any) {
        cursor += 1
        if cursor >= datas.count {
            cursor = 0
        }
        tableView.reloadRows(at: [IndexPath(row: datas.count, section: 0)], with: .fade)
    }
}
