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
import Sinch
import CoreLocation
import APESuperHUD
import Toast_Swift
import FirebaseAuth
import FirebaseInAppMessaging
import LUExpandableTableView

//struct AllUser: Decodable {
//    let group_member: [Object]
//}
//
//struct /*User*/Object:Decodable {
//       var xx : String!
//       var yy : [String]!
//}
//struct Coins:Decodable {
//    let current_coin: [Object2]
//}
//struct /*User*/Object2:Decodable {
//       var xx : String!
//       var yy : [String]!
//}

class FirstViewController: UIViewController,CLLocationManagerDelegate {
     var abc : [String] = []
     var def : [String] = []
//        var GroupName: [Group] = []
//        var current_coin: [Current_coin] = []
//        var a = ""
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    var curLat = ""
    var curLng = ""
    var c = 120
    var gameTimer: Timer?
    var date = ""
    let help = Helper()
    var user123: [String:Any] = []
   // var dict123 = []
    
    @IBOutlet weak var expandableTableView: LUExpandableTableView!
   private let cellReuseIdentifier = "SubMenuCell"
   private let sectionHeaderReuseIdentifier = "CategoryCell"
   var mainMenu = [String]()
   var subMenu = [[String]]()
   var GroupData : NSArray?
   var groupID = [Int]()
    @IBOutlet weak var coinupdate: UILabel!
//    /*searchName*/    var objectarray = [Object]()
//                      var objectarray2 = [Object2]()
    
//    let sinchClient : SINClient = Sinch.client(withApplicationKey: "ad000c89-eb44-4492-a22e-e46e4ca9ad4b", applicationSecret: "TbATI/+y00C0Jpb5VyMYUA==", environmentHost: "clientapi.sinch.com", userId: "saleafters@gmail.com")
//
//    var callClient : SINCallClient! ;
//    var call : SINCall! ;
//
//    func clientDidStart(_ client: SINClient!) {
//        print("Clien started")
//    }
//
//    func clientDidFail(_ client: SINClient!, error: Error!) {
//        print("Clien fail")
//    }
//    func clientDidStop(_ client: SINClient!) {
//
//    }
//
//    private func client(client: SINClient!, logMessage message: String!, area: String!, severity: SINLogSeverity, timestamp: NSDate!) {
//
//    }
//
//    func callDidProgress(_ call: SINCall!) {
//
//    }
//
//    func callDidEstablish(_ call: SINCall!) {
////        callStatus.text = "Call Connected"
//    }
//
//    func callDidEnd(_ call: SINCall!) {
//
//    }
//    func client(_ client: SINCallClient!, didReceiveIncomingCall call: SINCall!) {
//        call.delegate = self;
//        call.answer()
//
//    }
//    @IBAction func callMike(sender: AnyObject) {
//
//        let call : SINCall = callClient.callUser(withId: "NewMan@transformative.in")
//        call.delegate = self
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getMyList()
        coinUpdate()
        
        let now = Date()

        let formatter = DateFormatter()

        formatter.timeZone = TimeZone.current

        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateString = formatter.string(from: now)
        
        print("Current date time:-",dateString)
        self.date = dateString
        
        //This is process bar start code
        APESuperHUD.show(style: .loadingIndicator(type: .standard), title: nil, message: "Loading...")
        
        //This is getting current location when screen load
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        SendData()
        
        view.addSubview(expandableTableView)
         
        expandableTableView.register(SubMenuCell.self, forCellReuseIdentifier: "SubMenuCell")
         expandableTableView.register(UINib(nibName: "CategoryCell", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: sectionHeaderReuseIdentifier)
         let nib = UINib(nibName: "SubMenuCell", bundle: nil)
         
         expandableTableView.register(nib, forCellReuseIdentifier: "SubMenuCell")
         
         expandableTableView.expandableTableViewDataSource = self
         expandableTableView.expandableTableViewDelegate = self
         
         GetGroupData()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is TextViewController
        {
            let vc = segue.destination as? TextViewController
            vc?.userIDtest = "hello \(user123)"
        }
    }
    func GetGroupData()
        {
            self.mainMenu.removeAll()
            self.subMenu.removeAll()
            APESuperHUD.show(style: .loadingIndicator(type: .standard), title: nil, message: "Loading...")
            let headers = [
              "Content-Type": "application/x-www-form-urlencoded",
              "User-Agent": "PostmanRuntime/7.17.1",
              "Accept": "*/*",
              "Cache-Control": "no-cache",
              "Postman-Token": "aa32acab-ce48-4bf5-bcb7-50d6aa3c4439,faa05bbd-cf65-4c2f-8996-a4371836b7fb",
              "Host": "saleafterservice.com",
              "Accept-Encoding": "gzip, deflate",
              "Content-Length": "10",
              "Connection": "keep-alive",
              "cache-control": "no-cache"
            ]
            let user_id = "&user_id=" + UserController.instance.userid
            let postData = NSMutableData(data: "user_id=".data(using: String.Encoding.utf8)!)
            postData.append(user_id.data(using: String.Encoding.utf8)!)

            let request = NSMutableURLRequest(url: NSURL(string: "http://saleafterservice.com/takecare2u/main_api.php")! as URL,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10000.0)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = postData as Data

            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
              if (error != nil)
              {
                print(error)
              }
              else
              {
                let httpResponse = response as? HTTPURLResponse
    //            print(httpResponse)
                let JSONString = String(data: data!,encoding: .utf8)
    //            print(JSONString)
                
    //            let jsondata = self.help.convertToDictionary(text: JSONString!)
    //            print("Responce",jsondata)
    //
                let data = JSONString!.data(using: .utf8)!
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
                    {
                        print(jsonArray.count) // use the json here
                        self.GroupData = jsonArray as NSArray
                        
                        for i in jsonArray
                        {
                            print(i)
                            let t = i as! NSDictionary
                            let group_name = t["group_name"] as! String
    //                        print("Group Name:-",group_name)
                            
                            let group_id = t["group_id"] as! NSNumber
                            print("Group ID->",group_id)
                            self.groupID.append(Int(group_id))
                            
                            
                            
                            self.mainMenu.append(group_name)
                            print("Main menu Count->",self.mainMenu.count)
                            
                            var tmpArray = [String]()
                            let group_member = t["group_member"] as! NSArray
                            for j in group_member
                            {
                                let temp = j as! NSDictionary
                                let user_name = temp["user_name"] as! String
                                let user_lastname = temp["user_lastname"] as! String
                                
                                let UserFullname = user_name + " " + user_lastname
                                print("User Full name:-",UserFullname)
                                tmpArray.append(UserFullname)
                            }
                            self.subMenu.append(tmpArray)
                        }
                        
                        print("Group id count->",self.groupID.count)
                        
                        //now i will add groupid array to userdefault (session variable that can hold data)
                        UserDefaults.standard.set(self.groupID, forKey: "GroupIDArray")
                        
                        
                        
                    }
                    else
                    {
                        print("bad json")
                    }
                } catch let error as NSError {
                    print(error)
                }
                
                DispatchQueue.main.async
                {
                    APESuperHUD.dismissAll(animated: true)
                    self.expandableTableView.reloadData()
                }
              }
            })

            dataTask.resume()
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
    }
    func getMyList(){
    let parameters: Parameters = [
     "user_id": UserController.instance.userid
    ]
    let url = "http://saleafterservice.com/takecare2u/main_api.php"
    Alamofire.request(url, method: .post, parameters: parameters)
        .validate()
        .responseJSON { response in
          let json = JSON(response.result.value)
            for(key,value) in json{
            let name = value["group_name"].stringValue
            self.abc.append(name)
//            print(self.abc)
//            print(self.objectarray)
        }
        }
    }
    func coinUpdate(){
    let current_coin:String = "current_coin"
    let parameters: Parameters = [
     "user_id": UserController.instance.userid,
     "current_coin": current_coin
    ]
    let url = "http://saleafterservice.com/takecare2u/current_coin_api.php"
    Alamofire.request(url, method: .post, parameters: parameters)
        .validate()
        .responseJSON { response in
          let json = JSON(response.result.value)
//        for(key,value) in json{
            let coin = json["current_coin"].stringValue
            self.def.append(coin)
            print(coin)
            self.coinupdate.text = coin
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
        {
    //        locationManager.stopUpdatingLocation()
            let location = locations.last! as CLLocation
                   
            
            // This variable holds current lat and long
                   let CurrentLat = location.coordinate.latitude.description
                   let CurrentLng = location.coordinate.longitude.description
            
            self.curLat = CurrentLat
            self.curLng = CurrentLng
            
//            print("Current Lat :- ",self.curLat)
//            print("Current Lng :- ",self.curLng)
            
//            self.lblCurLat.text = "Current Lat :- " + self.curLat
//            self.lblCurLng.text = "Current Lng :- " + self.curLng
            
            DispatchQueue.main.async
            {
                 APESuperHUD.dismissAll(animated: true)
            }
        }
    @objc func runTimedCode()
           {
               if c <= 0
               {
//                print("Automatic Data will be send in " + c.description + " Seconds.")
    //               gameTimer?.invalidate()
                c = 120
                SendData()
                   
               }
               else
               {
//                print("Automatic Data will be send in " + c.description + " Seconds.")
                   c = c - 1
               }
              
           }
    func SendData()
        {
     APESuperHUD.show(style: .loadingIndicator(type: .standard), title: nil, message: "Loading...")
            let headers = [
              "Content-Type": "application/x-www-form-urlencoded",
              "User-Agent": "PostmanRuntime/7.17.1",
              "Accept": "*/*",
              "Cache-Control": "no-cache",
              "Postman-Token": "16efea81-35d8-4270-b2fc-3f74fbdf9393,f30b2d65-7b57-4457-b3a8-d964f82e3ce9",
              "Host": "saleafterservice.com",
              "Accept-Encoding": "gzip, deflate",
              "Content-Length": "92",
              "Connection": "keep-alive",
              "cache-control": "no-cache"
            ]
            
            let paraLat = "&gps_lat=" + self.curLat
            let paraLng = "&gps_long=" +  self.curLng
            let paraDate = "&gps_datetime=" + self.date
            let user_id = "&user_id=" + UserController.instance.userid

            let postData = NSMutableData(data: "gps_update=".data(using: String.Encoding.utf8)!)
            postData.append(user_id.data(using: String.Encoding.utf8)!)
            postData.append(paraLat.data(using: String.Encoding.utf8)!)
            postData.append(paraLng.data(using: String.Encoding.utf8)!)
            postData.append(paraDate.data(using: String.Encoding.utf8)!)

            let request = NSMutableURLRequest(url: NSURL(string: "http://saleafterservice.com/takecare2u/update_gps_location_api.php")! as URL,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10000.0)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = postData as Data

            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
              if (error != nil)
              {
                print(error)
              }
              else
              {
                 let httpResponse = response as? HTTPURLResponse
                              //                print(httpResponse)
                let JSONString = String(data: data!,encoding: .utf8)
                              //                print(JSONString)
                              
            
                let jsondata = self.help.convertToDictionary(text: JSONString!)
                print("Responce",jsondata)
                DispatchQueue.main.async
                {
                    self.view.makeToast("Data Send Succesfully..")
                    APESuperHUD.dismissAll(animated: true)
                    self.c = 120
                    self.gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.runTimedCode), userInfo: nil, repeats: true)
                }
              }
            })

            dataTask.resume()
            
            
    //        self.gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.runTimedCode), userInfo: nil, repeats: true)
        }
}
extension FirstViewController: LUExpandableTableViewDataSource {
    func numberOfSections(in expandableTableView: LUExpandableTableView) -> Int {
        return mainMenu.count
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        return subMenu[section].count
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
         // this is sub menu tableview Method
        let cell = expandableTableView.dequeueReusableCell(withIdentifier: "SubMenuCell", for: indexPath) as! SubMenuCell
        
        // this code is for showing crown
        let t = self.GroupData![indexPath.section] as! NSDictionary
        print(t)
        
        
        
        
       
        var CrownFlag = false
        let group_header = t["group_header"] as! String
        print("group_header",group_header)
        let group_member = t["group_member"] as! NSArray
        
        var c = 0
        for i in group_member
        {
            let item = i as! NSDictionary
            let user_id = item["user_id"] as! String
            print("user_id",user_id)
            print("Count->",c)
            break
            c = c + 1
        }
        
        print("Final Count->",c)
        
        if indexPath.row == c
        {
            cell.imgCrown.alpha = 1
        }
        else
        {
            cell.imgCrown.alpha = 0
            cell.lblLeading.constant = 0
            cell.CrownWidth.constant = 0
        }
        
        //this is show user fullname in label
        cell.lbl.text = subMenu[indexPath.section][indexPath.row]
        
        //this create action of checkbox button
        let SectionRow = indexPath.section.description + "," + indexPath.row.description
        cell.btnCheck.setTitle(SectionRow, for: .normal)
        
        cell.btnCheck.tag = indexPath.row
        cell.btnCheck.addTarget(self, action: #selector(Check(sender:)), for: .touchUpInside)
        
       

        
        return cell
    }
    
    
    // MARK: - Checkbox button Action method
       @objc func Check(sender: UIButton!)
       {

        //here getting indexpath.section and indexpath.row
        let FullIndex = sender.currentTitle
        let Split = FullIndex!.split{$0 == ","}.map(String.init)
//        print("fullNameArr->",Split)
        let mainIndex = Split[0]
//        print("mainIndex",mainIndex)
        let subIndex = Split[1]
//        print("subIndex",subIndex)
        
        
        //Here getting userid of selected check button
        let t = self.GroupData![Int(mainIndex)!] as! NSDictionary
        let group_member = t["group_member"] as! NSArray
        var user = group_member[Int(subIndex)!] as! NSDictionary
        let user_id = user["user_id"] as! String
        print("user_id->",user_id)
//        let user_name = user["user_name"] as! String
//        print("user_name->",user_name)
        
        if sender.isSelected == true
        {
            sender.isSelected = false
            print("Unchecked UserID ->",user_id)
            user123[user_id] = user_id
            var user123 = user_id
            var abc11 = [Character]
            //let check:String = user_id
            if let index = user123.firstIndex(of: abc11){
                user123.remove(at: index)
            }
//            print(user123)
        }
        else
        {
            sender.isSelected = true
             print("Checked UserID ->",user_id)
            user123[user_id] = user_id
//            var user123 = user_id
//            self.user123.append(user_id)
            print(user123)
        }
       }
    
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, sectionHeaderOfSection section: Int) -> LUExpandableTableViewSectionHeader {
        guard let sectionHeader = expandableTableView.dequeueReusableHeaderFooterView(withIdentifier: sectionHeaderReuseIdentifier) as? CategoryCell else {
            assertionFailure("Section header shouldn't be nil")
            return LUExpandableTableViewSectionHeader()
        }
        
        sectionHeader.label.text = mainMenu[section]
        sectionHeader.expandCollapseButton.tag = section
        
        return sectionHeader
    }
}

// MARK: - LUExpandableTableViewDelegate

extension FirstViewController: LUExpandableTableViewDelegate {
    func expandableTableView(_ expandableTableView: LUExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        /// Returning `UITableViewAutomaticDimension` value on iOS 9 will cause reloading all cells due to an iOS 9 bug with automatic dimensions
        return 50
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, heightForHeaderInSection section: Int) -> CGFloat {
        /// Returning `UITableViewAutomaticDimension` value on iOS 9 will cause reloading all cells due to an iOS 9 bug with automatic dimensions
        return 69
    }
    
    // MARK: - Optional
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, didSelectRowAt indexPath: IndexPath)
    {
        print("Did select cell at section \(indexPath.section) row \(indexPath.row)")
        
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, didSelectSectionHeader sectionHeader: LUExpandableTableViewSectionHeader, atSection section: Int)
    {
        print("Did select section header at section \(section)")
        UserDefaults.standard.set(section, forKey: "SelSection")
        
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("Will display cell at section \(indexPath.section) row \(indexPath.row)")
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, willDisplaySectionHeader sectionHeader: LUExpandableTableViewSectionHeader, forSection section: Int) {
        print("Will display section header for section from tap \(section)")
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func expandableTableView(_ expandableTableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
