//
//  QRcodeGenerator.swift
//  Takecare2uV1
//
//  Created by Sherlock Ohm on 22/10/2562 BE.
//  Copyright © 2562 Sherlock Ohm. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class QRcodeGenerator: UIViewController {

    @IBOutlet weak var QRcode: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get define string to encode
        let myString = UserController.instance.userid
        // Get data from the string
        let data = myString.data(using: String.Encoding.ascii)
        // Get a QR CIFilter
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return }
        // Input the data
        qrFilter.setValue(data, forKey: "inputMessage")
        // Get the output image
        guard let qrImage = qrFilter.outputImage else { return }
        // Scale the image
        let transform = CGAffineTransform(scaleX: 50, y: 50)
        let scaledQrImage = qrImage.transformed(by: transform)
        
        let image = UIImage(ciImage: scaledQrImage)
        QRcode.image = image

    }

}
