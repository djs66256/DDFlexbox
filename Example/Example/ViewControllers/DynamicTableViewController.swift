//
//  DynamicTableViewController.swift
//  Example
//
//  Created by daniel on 2021/9/15.
//  Copyright © 2021 daniel. All rights reserved.
//

import Foundation


class DynamicTableViewController : UITableViewController {
    
    var datas : [DDDynamicTableViewCellModel] = []
    
    init() {
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        self.tableView.register(DDDynamicTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func buildModel(image: UIImage?, text: String?, detailText: String?) -> DDDynamicTableViewCellModel {
        let model = DDDynamicTableViewCellModel()
        model.image = image
        model.text = text
        model.detailText = detailText
        return model
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DDDynamicTableViewCell
        cell.model = datas[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DDDynamicTableViewCell
        cell.model = datas[indexPath.row]
        let size = cell.sizeThatFits(CGSize(width: tableView.frame.width, height: CGFloat.greatestFiniteMagnitude))
        return size.height
    }
}
