//
//  FirstViewController.swift
//  Takecare2uV1
//
//  Created by Sherlock Ohm on 10/10/2562 BE.
//  Copyright © 2562 Sherlock Ohm. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class FirstViewController: UIViewController {
    var GroupName: [Group] = []
    struct Object {
        var xx : String!
        var yy : [String]!
    }
    var objectarray = [Object]()
    
    @IBOutlet weak var btnDrop: UIButton!
    @IBOutlet weak var tblView: UITableView!
    
    var fruitList = ["Orange", "Banana", "Apple", "Blueberry", "Mango", "Cherry", "Grape", "Strawberry"]

    override func viewDidLoad() {
        super.viewDidLoad()
        getMyList()
        initTableView()
        tblView.isHidden = true
    }    
    @IBOutlet var coinSelect: [UIButton]!
    @IBAction func handleSelection(_ sender: UIButton) {
        coinSelect.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    @IBAction func coinTapped(_ sender: UIButton) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onClickDropButton(_ sender: Any) {
        if tblView.isHidden {
            animate(toogle: true, type: btnDrop)
        } else {
            animate(toogle: false, type: btnDrop)
        }
    }
    func getMyList(){
        let parameters: Parameters = [
           "user_id": UserController.instance.userid,
           "platform": "IOS"
          ]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let URL = "http://saleafterservice.com/takecare2u/main_api.php"
        if ReachabilityTest.isConnectedToNetwork() {
            Alamofire.request(URL,method: .post,parameters:parameters).validate()
                .responseJSON { response in
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let json = JSON(response.result.value!)
                    let data = json.map { (_, js) in Group.parseJSON(json: js) }
                    self.GroupName = Array(data)
                    print(json)
                    
            }
        }else {
            Constant().showAlert(title: "Error", message: "No internet connection available", viewController: self)
        }
        
    }
    func animate(toogle: Bool, type: UIButton) {
        if type == btnDrop {
        if toogle {
            UIView.animate(withDuration: 0.3) {
                self.tblView.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.tblView.isHidden = true
            }
        }
        } 
    }
}
extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
    fileprivate func initTableView() {
        tblView.dataSource = self
        tblView.delegate = self
//        tblView.rowHeight = UITableView.automaticDimension
//        tblView.tableFooterView = UIView()
    }
    func numberOfSections(in tableView: UITableView) -> Int{
           return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroupName.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let Test = GroupName[indexPath.row]
        cell.TextField.text = Test.groupName
        print(Test.groupName)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        btnDrop.setTitle("\(GroupName[indexPath.row])", for: .normal)
        animate(toogle: false, type: btnDrop)
    }
}

