//
//  GradientView.swift
//  Takecare2uV1
//
//  Created by Sherlock Ohm on 30/9/2562 BE.
//  Copyright © 2562 Sherlock Ohm. All rights reserved.
//

import UIKit

class GradientView: UIView {

   override open class var layerClass: AnyClass {
       return CAGradientLayer.classForCoder()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [UIColor.init(red: 0/255, green: 10/255, blue: 134/255, alpha: 1).cgColor, UIColor.init(red: 0/255, green: 199/255, blue: 251/255, alpha: 1).cgColor]
    }

}
