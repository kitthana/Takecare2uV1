//
//  RegisterViewController.swift
//  Takecare2uV1
//
//  Created by Sherlock Ohm on 30/9/2562 BE.
//  Copyright © 2562 Sherlock Ohm. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterViewController:UIViewController{
    @IBOutlet weak var privacy: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var switchRegister: UISwitch!
    @IBOutlet weak var registerButton: UIButton!
    override func viewDidLoad() {
    super.viewDidLoad()
        registerButton.backgroundColor = UIColor.systemBlue
        registerButton.layer.cornerRadius = 7
        registerButton.setTitleColor(UIColor.white, for: .normal)
        registerButton.layer.shadowColor = UIColor.black.cgColor
        registerButton.layer.shadowRadius = 4
    }
    
    func validateFields() -> String? {
        if usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            countryTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            phoneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        return nil
    }
    var status:Bool? = false
    @IBAction func switchPrivacy(_ sender: UISwitch) {
        if switchRegister.isOn == true {
            status=true
            print(status)
        }
        else{
            status=false
            print(status)
        }
    }
    @IBAction func tapRegister(_ sender: Any) {
        let error = validateFields()
        let x = status
        print(status)
        
        if error != nil {
            Constant().showAlert(title: "Error", message: "Please fill in all fields.", viewController: self)
        }
        if x==true {
                let username = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let password_1 = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let password_2 = confirmPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let user_name = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let user_surname = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let user_country = countryTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let user_tell = phoneTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let user_email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let encryptPassword1 = password_1.sha1()
                let encryptPassword2 = password_2.sha1()
                Register(username, password_1: encryptPassword1, password_2: encryptPassword2, user_name: user_name, user_surname: user_surname, user_country: user_country, user_tell: user_tell, user_email: user_email)
                Constant().showAlert(title: "Success", message: "Already registered", viewController: self)
        }
        else{
             Constant().showAlert(title: "Error", message: "Please check Privacy Policy.", viewController: self)
            }
    }
    
    fileprivate func Register(_ username: String, password_1: String, password_2: String, user_name: String, user_surname: String, user_country: String, user_tell: String, user_email: String) {
        let register:String = "register"
        let parameters: Parameters = [
            "username": username,
            "password_1": password_1,
            "password_2": password_2,
            "user_name": user_name,
            "user_surname": user_surname,
            "user_country": user_country,
            "user_tell": user_tell,
            "user_email": user_email,
            "register": register
        ]
        let url = "http://saleafterservice.com/takecare2u/register_api.php"
        Alamofire.request(url, method: .post, parameters: parameters)
            .validate()
            .responseJSON { response in
                let json = JSON(response.result.value)
                let status = json["status"].stringValue
                let type = json["type"].stringValue
                if status == "success" {
                    print(json)
                    self.transitionToHome()
                }
                else {
                    Constant().showAlert(title: "Error", message: "Register Failed", viewController: self)
                }
            }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func transitionToHome() {
        
        let MainViewController = storyboard?.instantiateViewController(identifier: Constant.Storyboard.MainViewController) as? MainViewController
        
        view.window?.rootViewController = MainViewController
        view.window?.makeKeyAndVisible()
        
    }
}
