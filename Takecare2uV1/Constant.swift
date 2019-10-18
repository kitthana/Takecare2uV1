//
//  Constant.swift
//  Alamofire
//
//  Created by Sherlock Ohm on 30/9/2562 BE.
//

import Foundation
import UIKit

class Constant{
    func showAlert(title:String,message:String,viewController :UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let resultAlert = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(resultAlert)
        viewController.present(alert, animated: true, completion: nil)
    }
     struct Storyboard {
        
        static let MainViewController = "MainVC"
        static let ViewController = "loginView"
        
    }
    
}


