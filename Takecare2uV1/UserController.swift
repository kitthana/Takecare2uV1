//
//  UserController.swift
//  Takecare2uV1
//
//  Created by Sherlock Ohm on 14/10/2562 BE.
//  Copyright © 2562 Sherlock Ohm. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserController {

    static let instance = UserController()

    public var userid: String {
        get {
            guard let userid = UserDefaults().value(forKey: "user_id") as? String else { return "" }
            return userid
        }
        set(userid) {
            UserDefaults().set(userid, forKey: "user_id")
        }
    }
    public var group_name: String {
        get {
            guard let group_name = UserDefaults().value(forKey: "group_name") as? String else { return "" }
            return group_name
        }
        set(group_name) {
            UserDefaults().set(group_name, forKey: "group_name")
        }
    }
}
struct Group {
//    var group_id:String
    var group_name:String
//    var group_header:String
//    var group_image:String
//    var group_timestart:String
//    var group_timestop:String
}

extension Group{
    
    static func parseJSON(json:JSON)->Group{
//        let group_id = json["group_id"].stringValue
        let group_name = json["group_name"].stringValue
//        let group_header = json["group_header"].stringValue
//        let group_image = json["group_image"].stringValue
//        let group_timestart = json["group_timestart"].stringValue
//        let group_timestop = json["group_timestop"].stringValue
        return Group(group_name: group_name)
    }
}
struct Current_coin {
    var current_coin:String
}

extension Current_coin{
    
    static func parseJSON(json:JSON)->Current_coin{
        let current_coin = json["current_coin"].stringValue
        return Current_coin(current_coin: current_coin)
    }
}
