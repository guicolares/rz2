//
//  RZ2Units.swift
//  test
//
//  Created by Guilherme Leite Colares on 03/08/17.
//  Copyright © 2017 rz2. All rights reserved.
//

import UIKit
import CoreData

class RZ2UnitsTableViewController: UITableViewController {
    
    @IBOutlet var unitTableView: UITableView!
    
    var units: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.unitTableView.tableFooterView = UIView()
        RZ2Manager().listUnits { (result, error) in
            if let units = result {
                self.units = units
                self.unitTableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.units.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
        let unit = self.units[indexPath.row]
            
        let cell = self.unitTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RZ2UnitTableViewCell
        cell.lblName.text = unit.value(forKey: "name") as? String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowDetail", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "ShowDetail":
                let vc = segue.destination as! RZ2UnitDetailTableViewController
                vc.unit = self.units[sender as! Int]
            default:
                break
            }
        }
    }
    
    @IBAction func clickOnLogout(_ sender: UIBarButtonItem) {
        let optionMenu = UIAlertController(title: nil, message: "Are you shure you want log out ?", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Yes", style: .destructive) { (action) in
            RZ2User.sharedInstance.reset()
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let lvc = storyBoard.instantiateViewController(withIdentifier: "RZ2LoginNavigationViewController")
            lvc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(lvc, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(logoutAction)
        optionMenu.addAction(cancelAction)
        
        if let popoverController = optionMenu.popoverPresentationController {
            popoverController.barButtonItem = sender
        }
        
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    
    
    
}
