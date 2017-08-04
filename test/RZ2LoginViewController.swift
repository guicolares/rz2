//
//  ViewController.swift
//  test
//
//  Created by Guilherme Leite Colares on 02/08/17.
//  Copyright © 2017 rz2. All rights reserved.
//

import UIKit

class RZ2LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.txtEmail.text = "mobile@gmail.com"
        self.txtPassword.text = "1234"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func clickOnLogin(_ sender: UIButton) {
        let email = self.txtEmail.text
        let password = self.txtPassword.text
        self.view.endEditing(true)
        
        let alertController = UIAlertController(title: "Message", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        
        if email == nil || email == "" {
            alertController.message = "e-mail is empty"
            self.present(alertController, animated: true, completion: nil)
            
        }else if password == nil || password == ""{
            alertController.message = "password is empty"
            self.present(alertController, animated: true, completion: nil)
        }else{
            //call web service
            let params: [String: String] = [
                "email": email!,
                "password": password!
            ]
            
            RZ2Manager().login(params, result: { (success, error) in
                if let hasUser = success {
                    if hasUser {
                        self.performSegue(withIdentifier: "ShowUnits", sender: nil)
                    }else{
                        alertController.message = "E-mail or password is incorrect"
                        self.present(alertController, animated: true, completion: nil)
                    }
                }else{ // show error ?
                    print(error!)
                }
            })
        }
    
    }

}

