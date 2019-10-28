//
//  SubMenuCell.swift
//  Takecare2uV1
//
//  Created by Sherlock Ohm on 27/10/2562 BE.
//  Copyright © 2562 Sherlock Ohm. All rights reserved.
//

import UIKit

class SubMenuCell: UITableViewCell
{
    
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var imgCrown: UIImageView!
    @IBOutlet weak var lblLeading: NSLayoutConstraint!
    @IBOutlet weak var CrownWidth: NSLayoutConstraint!
    @IBOutlet weak var crownLeading: NSLayoutConstraint!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        print("call submenu cell")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
