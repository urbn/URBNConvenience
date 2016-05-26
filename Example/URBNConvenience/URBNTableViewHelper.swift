//
//  URBNTableViewHelper.swift
//  URBNConvenience
//
//  Created by Bueno McCartney on 5/25/16.
//  Copyright © 2016 jgrandelli. All rights reserved.
//

import UIKit
import URBNConvenience

enum Cell {
    static var Helper: ReusableCell<URBNTableViewHelperCell> {
        return ReusableCell(identifier: "Cell.HelperCell")
    }
}

class URBNTableViewHelper: UITableViewController {
    let dataSource = [["title": "Title1", "detail":"Detail 1"], ["title": "Title2", "detail":"Detail 2"], ["title": "Title3", "detail":"Detail 3"], ["title": "Title4", "detail":"Detail 4"], ["title": "Title5", "detail":"Detail 5"]]
    
    override init(style: UITableViewStyle) {
        super.init(style: .Plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataSource.count)
        title = "TableViewHelper"
        tableView.registerReusableCell(Cell.Helper)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellData = dataSource[indexPath.row] 
        let cell = tableView.dequeueReusableCell(Cell.Helper, indexPath: indexPath)
        
        cell.updateCellContent(cellData)
        
        return cell
    }
}
