//
//  ExpandableTableView.swift
//  ExpandableTableViewExample
//
//  Created by Can Kalender on 13.07.2019.
//  Copyright © 2019 Can Kalender. All rights reserved.
//

import UIKit

class ExpandableTableView: UITableViewController{
    var tableViewData = [CellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewData = [CellData(opened: false, title: "Row1", sectionData: ["Cell1","Cell2","Cell3"]),
                         CellData(opened: false, title: "Row2", sectionData: ["Cell1","Cell2","Cell3"]),
                         CellData(opened: false, title: "Row3", sectionData: ["Cell1","Cell2","Cell3"]),
                         CellData(opened: false, title: "Row4", sectionData: ["Cell1","Cell2","Cell3"])
        ]
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true{
            return tableViewData[section].sectionData.count + 1
        }else{
            return 1
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].title
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
             cell.textLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
            
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            if tableViewData[indexPath.section].opened == true{
                tableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .left)
            }else{
                tableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .right)
            }
        }else {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmptyViewController") as! EmptyViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
