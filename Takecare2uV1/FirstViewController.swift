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

class FirstViewController: UIViewController,SINCallClientDelegate, SINCallDelegate, SINClientDelegate,UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate {
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
       
    @IBOutlet weak var coinupdate: UILabel!
//    /*searchName*/    var objectarray = [Object]()
//                      var objectarray2 = [Object2]()
    
    let sinchClient : SINClient = Sinch.client(withApplicationKey: "ad000c89-eb44-4492-a22e-e46e4ca9ad4b", applicationSecret: "TbATI/+y00C0Jpb5VyMYUA==", environmentHost: "clientapi.sinch.com", userId: "saleafters@gmail.com")
    
    var callClient : SINCallClient! ;
    var call : SINCall! ;
    
    func clientDidStart(_ client: SINClient!) {
        print("Clien started")
    }
    
    func clientDidFail(_ client: SINClient!, error: Error!) {
        print("Clien fail")
    }
    func clientDidStop(_ client: SINClient!) {

    }

    private func client(client: SINClient!, logMessage message: String!, area: String!, severity: SINLogSeverity, timestamp: NSDate!) {

    }

    func callDidProgress(_ call: SINCall!) {

    }

    func callDidEstablish(_ call: SINCall!) {
//        callStatus.text = "Call Connected"
    }

    func callDidEnd(_ call: SINCall!) {

    }
    func client(_ client: SINCallClient!, didReceiveIncomingCall call: SINCall!) {
        call.delegate = self;
        call.answer()

    }
    @IBAction func callMike(sender: AnyObject) {

        let call : SINCall = callClient.callUser(withId: "NewMan@transformative.in")
        call.delegate = self

    }
    @IBOutlet weak var btnDrop: UIButton!
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMyList()
        coinUpdate()
        print(sinchClient.userId)
        tblView.dataSource = self
        tblView.delegate = self
        tblView.isHidden = true
        
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
        
    }    
    @IBOutlet var coinSelect: [UIButton]!
    @IBOutlet var menuSelect: [UIButton]!
    @IBAction func handleSelection(_ sender: UIButton) {
        coinSelect.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    @IBAction func handleSelectionmenu(_ sender: UIButton) {
        menuSelect.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    @IBAction func menuTapped(_ sender: UIButton) {
    }
    @IBAction func coinTapped(_ sender: UIButton) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        sinchClient.setSupportCalling(true)
        sinchClient.start()
        sinchClient.startListeningOnActiveConnection()
        sinchClient.delegate = self
        callClient = sinchClient.call()
    }
    @IBAction func onClickDropButton(_ sender: Any) {
        if tblView.isHidden {
            animate(toogle: true, type: btnDrop)
        } else {
            animate(toogle: false, type: btnDrop)
        }
        tblView.reloadData()
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.abc.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //cell.textLabel?.text = objectarray[indexPath.row].yy
        cell.textLabel?.text = abc[indexPath.row]
        print(indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        btnDrop.setTitle("\(abc[indexPath.row])", for: .normal)
        animate(toogle: false, type: btnDrop)
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
            
            print("Current Lat :- ",self.curLat)
            print("Current Lng :- ",self.curLng)
            
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
                print("Automatic Data will be send in " + c.description + " Seconds.")
    //               gameTimer?.invalidate()
                c = 120
                SendData()
                   
               }
               else
               {
                print("Automatic Data will be send in " + c.description + " Seconds.")
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
