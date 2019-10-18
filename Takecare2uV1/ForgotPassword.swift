//
//  ForgotPassword.swift
//  Takecare2uV1
//
//  Created by Sherlock Ohm on 2/10/2562 BE.
//  Copyright © 2562 Sherlock Ohm. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ForgotPassword: UIViewController {
@IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendForgotPassword(_ sender: Any) {
        if let username = usernameTextField.text, !(username.isEmpty) {
            forgot(username)
        }
        else {
            Constant().showAlert(title: "Error", message: "Please fill in username field.", viewController: self)
        }
    }
    fileprivate func forgot(_ username: String) {
        let forgot_password:String = "forgot_password"
        let parameters: Parameters = [
            "username": username,
            "forgot_password": forgot_password
        ]
        let url = "http://saleafterservice.com/takecare2u/forgot_password.php"
        Alamofire.request(url, method: .post, parameters: parameters)
            .validate()
            .responseJSON { response in
                let json = JSON(response.result.value)
                let status = json["status"].stringValue
                let type = json["type"].stringValue
                if status == "success" {
                     Constant().showAlert(title: "Success", message: "Password has been sent.", viewController: self)
                }
                else {
                    Constant().showAlert(title: "Error", message: "Send Failed", viewController: self)
                }
            }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
      }
    
   
}
