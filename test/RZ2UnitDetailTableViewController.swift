//
//  RZ2UnitDetailTableViewController.swift
//  test
//
//  Created by Guilherme Leite Colares on 04/08/17.
//  Copyright © 2017 rz2. All rights reserved.
//

import UIKit
import CoreData

class RZ2UnitDetailTableViewController: UITableViewController {

    var unit: NSManagedObject!
    var infos = ["name", "email", "address"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.infos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let info = self.infos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellDetail", for: indexPath)
        (cell.viewWithTag(1) as! UILabel).text = info
        (cell.viewWithTag(2) as! UILabel).text = self.unit.value(forKey: info) as? String
        return cell
    }
}
