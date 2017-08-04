//
//  RZ2Manager.swift
//  test
//
//  Created by Guilherme Leite Colares on 02/08/17.
//  Copyright © 2017 rz2. All rights reserved.
//

import Alamofire
import CoreData

class RZ2Manager {
    var URL = "http://54.208.92.83/checklist_novo/Application/public/mobile/"
    
    func login(_ params: Dictionary<String, String>, result: @escaping (_ success: Bool?, _ error: NSError?) -> Void ){
        self.URL += "login"
        
        Alamofire.request(self.URL, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.result.isSuccess {
                if let response = response.result.value as? [String: Any] {
                    if let _ = response["code"] as? Int { //check type of code ? 
                        result(false,nil)
                    }else{
                        let data = response["data"] as! [String: Any]
                        let user = RZ2User(name: data["name"] as! String,
                                           id: data["id"] as! Int,
                                           token: data["token"] as! String,
                                           companyId: data["company_id"] as! Int
                        )
                        user.sync()
                        result(true, nil)
                    }
                   
                }else{
                    result(nil, NSError(domain: response.result.description, code: 404, userInfo: nil))
                }
            }
        }
    }
    
    
    func listUnits(result: @escaping ([NSManagedObject]?, NSError?) -> Void ){
        self.URL += "units"
        let header = ["authorization": "Bearer " + RZ2User.sharedInstance.token]
        Alamofire.request(self.URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: header).responseJSON { (response) in
            if response.result.isSuccess {
                if let response = response.result.value as? [String: Any] {
                    if let _ = response["code"] as? Int {
                        print("error") //get by coreData ?
                        result(RZ2UnitsCoreData.fetch(), nil)
                    }else{
                        let units = (response["data"] as! [String: Any])["units"] as! [[String: Any]]
                        result(RZ2UnitsCoreData.save(units: units), nil)
                    }
                }
            }else{ //get by CoreData
                result(RZ2UnitsCoreData.fetch(), nil)
            }
        }
    }


    

}
