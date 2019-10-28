//
//  TextViewController.swift
//  Takecare2uV1
//
//  Created by Sherlock Ohm on 28/10/2562 BE.
//  Copyright © 2562 Sherlock Ohm. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    
    var userIDtest:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        lblName?.text = userIDtest

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var lblName: UILabel!
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
