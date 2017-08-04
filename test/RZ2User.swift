//
//  RZ2User.swift
//  test
//
//  Created by Guilherme Leite Colares on 02/08/17.
//  Copyright © 2017 rz2. All rights reserved.
//
import Foundation

class RZ2User: NSObject, NSCoding {
    static var sharedInstance: RZ2User!
  
    var name: String!
    var id: Int!
    var token: String!
    var companyId: Int!
    
    init(name: String, id: Int, token: String, companyId: Int) {
        self.name = name
        self.id = id
        self.token = token
        self.companyId = companyId
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: "name") as? String,
        let id = aDecoder.decodeObject(forKey: "id") as? Int,
        let token = aDecoder.decodeObject(forKey: "token") as? String,
        let companyId = aDecoder.decodeObject(forKey: "companyId") as? Int else{
            return nil
        }
        self.init(name: name, id: id, token: token, companyId: companyId)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.token, forKey: "token")
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.companyId, forKey: "companyId")
    }
    
    func sync(){
        let data = NSKeyedArchiver.archivedData(withRootObject: self)
        UserDefaults.standard.set(data, forKey: "user")
        RZ2User.sharedInstance = self
    }
    
    static func launch(){
        if let data = UserDefaults.standard.object(forKey: "user") as? Data {
            RZ2User.sharedInstance = NSKeyedUnarchiver.unarchiveObject(with: data) as? RZ2User
        }
    }
    
    func reset(){
         UserDefaults.standard.removeObject(forKey: "user")
    }
    
    
}
