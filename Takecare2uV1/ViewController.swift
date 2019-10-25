//
//  ViewController.swift
//  Takecare2uV1
//
//  Created by Sherlock Ohm on 30/9/2562 BE.
//  Copyright © 2562 Sherlock Ohm. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CryptoSwift
import FacebookCore
import FBSDKLoginKit
import GoogleSignIn
import Firebase
import FBSDKCoreKit

class ViewController: UIViewController,LoginButtonDelegate{
   
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupfacebookbutton()
        setupgooglebutton()
        
        loginView.layer.shadowColor = UIColor.black.cgColor
        loginView.layer.shadowOpacity = 0.4
        loginView.layer.shadowOffset = .zero
        loginView.layer.shadowRadius = 4
        loginView.layer.shadowPath = UIBezierPath(rect: loginView.bounds).cgPath
        loginView.layer.shouldRasterize = true
        loginView.layer.rasterizationScale = UIScreen.main.scale
        
        loginButton.backgroundColor = UIColor.systemBlue
        loginButton.layer.cornerRadius = 7
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.layer.shadowColor = UIColor.black.cgColor
        loginButton.layer.shadowRadius = 4
    }
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func didTapLoginButton(_ sender : Any) {
        if let username = usernameTextField.text, !(username.isEmpty) {
            if let password = passwordTextField.text, !(password.isEmpty) {
                let encryptPassword = password.sha1()
                if !(username.isEmpty) && !(password.isEmpty) {
                    login(username, password: encryptPassword)
                }
                else {
                    print("error")
                }
            }
        }

    }
    fileprivate func login(_ username: String, password: String) {
        let gotologin:String = "login"
        let parameters: Parameters = [
            "username": username,
            "password": password,
            "login": gotologin
        ]
        let url = "http://saleafterservice.com/takecare2u/login_api.php"
        Alamofire.request(url, method: .post, parameters: parameters)
            .validate()
            .responseJSON { response in
                let json = JSON(response.result.value)
                let status = json["status"].stringValue
                let type = json["type"].stringValue
                let user_id = json["user_id"].stringValue
                if status == "success" {
                    UserController.instance.userid = user_id
                    self.transitionToHome()
//                    print(user_id)
                }
                else {
                    Constant().showAlert(title: "Error", message: "Login Failed", viewController: self)
                }
            }
    }
    
    func transitionToHome() {
        
        let MainViewController = storyboard?.instantiateViewController(identifier: Constant.Storyboard.MainViewController) as? MainViewController
        
        view.window?.rootViewController = MainViewController
        view.window?.makeKeyAndVisible()
    }
    
    fileprivate func setupfacebookbutton(){
        let loginFBButton = FBLoginButton()
        view.addSubview(loginFBButton)
        loginFBButton.frame = CGRect(x: 25, y: 200, width: view.frame.width-50, height: 40)
        loginFBButton.delegate = self
    }
    func loginButton(_ loginButton: FBLoginButton!,didCompleteWith result: LoginManagerLoginResult!,error: Error!){

        if error != nil{
            print("error")
        }
        else if result.isCancelled{
            print("cancle")
        }else{
            
            self.transitionToHome()
            print(LoginManagerLoginResult?.self)
            let accessToken = AccessToken.current?.tokenString
            print("access token = \(accessToken.self)")
            getFbId()
        }
    }
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("logout")
    }
    
    fileprivate func setupgooglebutton(){
        let loginGGButton = GIDSignInButton()
        view.addSubview(loginGGButton)
        loginGGButton.frame = CGRect(x: 25, y: 250, width: view.frame.width-50, height: 30)
        GIDSignIn.sharedInstance().presentingViewController = self
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
    }
    func getUser() -> String{
        let preferences = UserDefaults.standard
        if preferences.string(forKey: "userid") != nil{
            let userid = preferences.string(forKey: "userid")
            return userid!
        } else {
            return ""
        }
    }
    func getFbId(){
        if(AccessToken.current != nil){
            let connection = GraphRequestConnection()
            connection.add(GraphRequest(graphPath: "/me", parameters: ["fields":"email"])) { httpResponse, result, error   in
                if error != nil {
                    NSLog(error.debugDescription)
                    return
                }

                // Handle vars
                if let result = result as? [String:String],
                    let email: String = result["email"],
                    let fbId: String = result["id"] {

                    // internal usage of the email
//                    self.userService.loginWithFacebookMail(facebookMail: email)
                    print(email)
                    print(fbId)
                }

            }
        }
    }
}
