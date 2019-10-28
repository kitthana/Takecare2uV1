//
//  AddMemberViewController.swift
//  Takecare2uV1
//
//  Created by Sherlock Ohm on 22/10/2562 BE.
//  Copyright © 2562 Sherlock Ohm. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddMemberViewController: UIViewController {
@IBOutlet weak var useridTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addMember(_ sender: Any) {
           if let user_id = useridTextField.text, !(user_id.isEmpty) {
               addMemberUserid(user_id)
           }
           else {
               Constant().showAlert(title: "Error", message: "Please fill in username field.", viewController: self)
           }
       }
       fileprivate func addMemberUserid(_ user_id: String) {
          let add_member:String = "add_member"
           let parameters: Parameters = [
               "user_id":  user_id,
               "group_id": "999" ,
               "add_member": add_member
           ]
           let url = "http://saleafterservice.com/takecare2u/add_member_api.php"
           Alamofire.request(url, method: .post, parameters: parameters)
               .validate()
               .responseJSON { response in
                   let json = JSON(response.result.value)
                   let status = json["status"].stringValue
                   let type = json["type"].stringValue
                   if status == "success" {
                        Constant().showAlert(title: "Success", message: "The client has been added.", viewController: self)
                   }
                   else {
                       Constant().showAlert(title: "Error", message: "Failed", viewController: self)
                   }
               }
       }
       override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.view.endEditing(true)
         }
       
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
