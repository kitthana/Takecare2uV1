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
    func getUserProfile() {
        let connection = GraphRequestConnection()
        connection.add(<#T##request: GraphRequest##GraphRequest#>, batchEntryName: "\me", completionHandler: <#T##GraphRequestBlock##GraphRequestBlock##(GraphRequestConnection?, Any?, Error?) -> Void#>) {
            reponse, result in
            switch result {
            case .success(let response):
                print("Logged in user facebook id == \(response.dictionaryValue!["id"])")
                print("Logged in user facebook name == \(response.dictionaryValue["name"])")
                break
            case .failed(let error):
                print("We have error with profile == \(error.localizeDesciption)")
            }
        }
    }

}
}
