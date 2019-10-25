//
//  editGroup.swift
//  Takecare2uV1
//
//  Created by Sherlock Ohm on 22/10/2562 BE.
//  Copyright © 2562 Sherlock Ohm. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import TinyConstraints

class editGroup: UIViewController {

    @IBOutlet weak var timePickerStart: UITextField!
    @IBOutlet weak var timePickerStop: UITextField!
    @IBOutlet weak var group_nameTextField: UITextField!
        let startTimePicker = UIDatePicker()
        func createstart(){
            startTimePicker.datePickerMode = .time
            timePickerStart.inputView = startTimePicker
            let toolbar1 = UIToolbar()
            toolbar1.sizeToFit()
            let doneButton1 = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneclickstart))
            toolbar1.setItems([doneButton1], animated: true)
            timePickerStart.inputAccessoryView = toolbar1
        }
        @objc func doneclickstart(){
            let timestartformat = DateFormatter()
            timestartformat.dateStyle = .none
            timestartformat.timeStyle = .short
            timePickerStart.text = timestartformat.string(from: startTimePicker.date)
            self.view.endEditing(true)
            
        }
        let stopTimePicker = UIDatePicker()
        func createstop(){
            stopTimePicker.datePickerMode = .time
            timePickerStop.inputView = stopTimePicker
            let toolbar2 = UIToolbar()
            toolbar2.sizeToFit()
            let doneButton2 = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneclickstop))
            toolbar2.setItems([doneButton2], animated: true)
            timePickerStop.inputAccessoryView = toolbar2
        }
        @objc func doneclickstop(){
            let timestopformat = DateFormatter()
            timestopformat.dateStyle = .none
            timestopformat.timeStyle = .short
            timePickerStop.text = timestopformat.string(from: stopTimePicker.date)
            self.view.endEditing(true)
            
        }

        
        let profileImageViewWidth: CGFloat = 100
        
        lazy var profileImageView: UIImageView = {
            let iv = UIImageView()
            iv.image = #imageLiteral(resourceName: "DefaultProfileImage").withRenderingMode(.alwaysOriginal)
            iv.contentMode = .scaleAspectFill
            iv.layer.cornerRadius = profileImageViewWidth / 2
            iv.layer.masksToBounds = true
            return iv
        }()
        
        lazy var profileImageButton: UIButton = {
            var button = UIButton(type: .system)
            button.backgroundColor = .clear
            button.layer.cornerRadius = profileImageViewWidth / 2
            button.layer.masksToBounds = true
            button.addTarget(self, action: #selector(profileImageButtonTapped), for: .touchUpInside)
            return button
        }()
        
        @objc fileprivate func profileImageButtonTapped() {
            print("Tapped button")
            showChooseSourceTypeAlertController2()
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            startTimePicker.datePickerMode = UIDatePicker.Mode.time
            createstart()
            createstop()
            setupViews()
        }

        fileprivate func setupViews() {
            view.backgroundColor = .white
            addViews()
            constrainViews()
        }
        
        fileprivate func addViews() {
            view.addSubview(profileImageView)
            view.addSubview(profileImageButton)
        }
        
        fileprivate func constrainViews() {
            profileImageView.topToSuperview(offset: 36, usingSafeArea: true)
            profileImageView.centerXToSuperview()
            profileImageView.width(profileImageViewWidth)
            profileImageView.height(profileImageViewWidth)
            
            profileImageButton.edges(to: profileImageView)
        }

    }

    extension editGroup: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        func showChooseSourceTypeAlertController2() {
            let photoLibraryAction = UIAlertAction(title: "Choose a Photo", style: .default) { (action) in
                self.showImagePickerController2(sourceType: .photoLibrary)
            }
            let cameraAction = UIAlertAction(title: "Take a New Photo", style: .default) { (action) in
                self.showImagePickerController2(sourceType: .camera)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            AlertChoosePhoto.showAlert(style: .actionSheet, title: nil, message: nil, actions: [photoLibraryAction, cameraAction, cancelAction], completion: nil)
        }
        
        func showImagePickerController2(sourceType: UIImagePickerController.SourceType) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            imagePickerController.sourceType = sourceType
            present(imagePickerController, animated: true, completion: nil)
        }
        
        func imagePickerController2(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                self.profileImageView.image = editedImage.withRenderingMode(.alwaysOriginal)
            } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                self.profileImageView.image = originalImage.withRenderingMode(.alwaysOriginal)
            }
            dismiss(animated: true, completion: nil)
        }
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
        fileprivate func Editgroup(_ group_name: String, group_image: String, group_timestart: String, group_timestop: String, user_id: String,group_id:String) {
            let edit_group:String = "edit_group"
            let parameters: Parameters = [
                "group_id": group_id,
                "group_name": group_name,
                "group_image": group_image,
                "group_timestart": group_timestart,
                "group_timestop": group_timestop,
                "user_id": user_id,
                "edit_group": edit_group
            ]
            let url = "http://saleafterservice.com/takecare2u/edit_group_api.php"
            Alamofire.request(url, method: .post, parameters: parameters)
                .validate()
                .responseJSON { response in
                    let json = JSON(response.result.value)
                    let status = json["status"].stringValue
                    let type = json["type"].stringValue
                    if status == "success" {
                        print(json)
                    }
                    else {
                        Constant().showAlert(title: "Error", message: "Failed", viewController: self)
                    }
                }
        }
        @IBAction func tapEditgroup(_ sender: Any) {
              let error = validateFields2()
              if error != nil {
                  Constant().showAlert(title: "Error", message: "Please fill in group name fields.", viewController: self)
              }
              else{
                      let group_timestart = timePickerStart.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                      let group_timestop = timePickerStop.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                      let group_name = group_nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                Editgroup(group_name, group_image: "aa",group_timestart: group_timestart, group_timestop: group_timestop, user_id: UserController.instance.userid, group_id: "118")
                      Constant().showAlert(title: "success", message: "Already add group", viewController: self)
            }
        }
            func validateFields2() -> String? {
                if group_nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                return "Please fill in all fields."
            }
            return nil
        }
        
    }
