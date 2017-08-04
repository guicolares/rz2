//
//  RZ2UnitsCoreData.swift
//  test
//
//  Created by Guilherme Leite Colares on 03/08/17.
//  Copyright © 2017 rz2. All rights reserved.
//

import UIKit
import CoreData


class RZ2UnitsCoreData {
    
    static func save(units: [ [String: Any]] ) -> [NSManagedObject]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Unit", in: managedContext)
        var objects: [NSManagedObject] = []
        RZ2UnitsCoreData.deleteAll()
        
        for unit in units {
            let unitObject = NSManagedObject(entity: entity!, insertInto: managedContext)
            unitObject.setValue(unit["address"] as! String, forKey: "address")
            unitObject.setValue(unit["email"] as! String, forKey: "email")
            unitObject.setValue(unit["id"] as! Int, forKey: "id")
            unitObject.setValue(unit["latitude"] as! String, forKey: "latitude")
            unitObject.setValue(unit["longitude"] as! String, forKey: "longitude")
            unitObject.setValue(unit["name"] as! String, forKey: "name")
            unitObject.setValue(unit["qr_code"] as! String, forKey: "qr_code")
            
            //the best way is using relationship :)
            var data = NSKeyedArchiver.archivedData(withRootObject: unit["country"] as Any )
            unitObject.setValue(data, forKey: "country")
            data = NSKeyedArchiver.archivedData(withRootObject: unit["state"] as Any)
            unitObject.setValue(data, forKey: "state")
            data = NSKeyedArchiver.archivedData(withRootObject: unit["city"] as Any)
            unitObject.setValue(data, forKey: "city")
            data = NSKeyedArchiver.archivedData(withRootObject: unit["regions_ids"] as Any)
            unitObject.setValue(data, forKey: "regions_ids")
            data = NSKeyedArchiver.archivedData(withRootObject: unit["checklists_ids"] as Any)
            unitObject.setValue(data, forKey: "checklists_ids")
            data = NSKeyedArchiver.archivedData(withRootObject: unit["additional_fields"] as Any)
            unitObject.setValue(data, forKey: "additional_fields")
            objects.append(unitObject)
            
           do{
                try managedContext.save()
            }catch _ {}
       
        }
        return objects
    }
    
    static func deleteAll(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Unit")
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        try! managedContext.execute(request)
        
    }
    
    static func fetch() -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Unit")
        return try! managedContext.fetch(fetchRequest) as! [NSManagedObject]
    }

}
