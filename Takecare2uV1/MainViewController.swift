//
//  MainViewController.swift
//  Takecare2uV1
//
//  Created by Sherlock Ohm on 1/10/2562 BE.
//  Copyright © 2562 Sherlock Ohm. All rights reserved.
//

import UIKit
import AMSlideMenu
import Alamofire
import SwiftyJSON
import Foundation

class MainViewController:AMSlideMenuMainViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func segueIdentifierForIndexPath(inLeftMenu indexPath: IndexPath!) -> String! {
        switch indexPath.row {
        case 0:
            return "vc1"
        case 1:
            return "vc2"
        case 2:
            return "vc3"
        case 3:
            return "vc4"
        case 4:
            return "vc5"
        default:
            return "vc7"
        }
    }
    override func configureLeftMenuButton(_ button: UIButton!) {
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.setImage(UIImage(named: "menu"), for: .normal)
    }
    
}
