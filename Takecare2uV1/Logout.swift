//
//  Logout.swift
//  Takecare2uV1
//
//  Created by Sherlock Ohm on 13/10/2562 BE.
//  Copyright © 2562 Sherlock Ohm. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class Logout: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        logoutTapped()
        // Do any additional setup after loading the view.
    }
    @objc func logoutTapped() {
        let alertController = UIAlertController(title: "Do you want to log out?", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancle", style: .cancel, handler: nil)
        let confirmAction = UIAlertAction(title: "Log out", style: .destructive) { action -> Void in
//            self.dismiss(animated: true, completion: nil)
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let signinVC = storyboard.instantiateViewController(identifier: "loginView")
//            self.present(signinVC, animated: true, completion: nil)
            LoginManager().logOut()
            self.transitionToLogin()
            

        }
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        present(alertController, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func transitionToLogin() {
        
        let LoginViewController = storyboard?.instantiateViewController(identifier: Constant.Storyboard.ViewController) as? ViewController
        
        view.window?.rootViewController = LoginViewController
        view.window?.makeKeyAndVisible()
    }

}
