//
//  deleteGroup.swift
//  Takecare2uV1
//
//  Created by Sherlock Ohm on 22/10/2562 BE.
//  Copyright © 2562 Sherlock Ohm. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class deleteGroup: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Deletegroup("126")
        // Do any additional setup after loading the view.
    }
    
    fileprivate func Deletegroup(_ group_id:String) {
        let delete_group:String = "delete_group"
        let parameters: Parameters = [
            "group_id": group_id,
            "delete_group": delete_group
        ]
        let url = "http://saleafterservice.com/takecare2u/delete_group_api.php"
        Alamofire.request(url, method: .post, parameters: parameters)
            .validate()
            .responseJSON { response in
                let json = JSON(response.result.value)
                let status = json["status"].stringValue
                let type = json["type"].stringValue
                if status == "success" {
                    print(json)
                    Constant().showAlert(title: "Success", message: "Successfully deleted the group", viewController: self)
                }
                else {
                    Constant().showAlert(title: "Error", message: "Failed", viewController: self)
                }
            }
    }
}
