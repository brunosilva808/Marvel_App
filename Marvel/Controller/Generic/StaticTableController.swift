//
//  StaticTableController.swift
//  Marvel
//
//  Created by Bruno Silva on 03/12/2018.
//

import UIKit

class StaticTableController: UITableViewController {
    
    var dataSource: [UITableViewCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.canCancelContentTouches = true
        self.tableView.tableFooterView = UIView(frame: .zero)
    }
}

extension StaticTableController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.dataSource[indexPath.row]
    }
}
