//
//  CategoryCell.swift
//  Takecare2uV1
//
//  Created by Sherlock Ohm on 27/10/2562 BE.
//  Copyright © 2562 Sherlock Ohm. All rights reserved.
//

import UIKit
import LUExpandableTableView
import DropDown

class CategoryCell: LUExpandableTableViewSectionHeader
{
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var expandCollapseButton: UIButton!
    
    let dropDown = DropDown()
    var SelGroupIndex = 0
   
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnLabel)))
        label?.isUserInteractionEnabled = true
        
        //Calling Dropdown Setup Method
        DropdownSetup()
        
        
        
    }
    
    // MARK: - Setup Dropdown
    func DropdownSetup()
    {
        dropDown.anchorView = self.expandCollapseButton // UIView or UIBarButtonItem
        
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = ["Action 1     ", "Action 2     ", "Action 3     ","Action 4     "]
        
        
        // This action will call when select item from dropdown
        dropDown.selectionAction =
        {
                [unowned self] (index: Int, item: String) in
//          print("Selected item: \(item) at index: \(index)")
            
            let GroupIDArray = UserDefaults.standard.array(forKey: "GroupIDArray")
            
            let selSection = UserDefaults.standard.integer(forKey: "SelSection")
            
            let SelGroupID = GroupIDArray![self.SelGroupIndex]
            
            print("Selected Dropdown Group ID is ->",SelGroupID)
            
            
        }
    }
    
    override var isExpanded: Bool {
        didSet {
            // Change the title of the button when section header expand/collapse
//            expandCollapseButton?.setTitle(isExpanded ? "Collapse" : "Expand", for: .normal)
            expandCollapseButton.setImage(isExpanded ? UIImage(named: "More") : UIImage(named: "More"), for: .normal)
        }
    }
    
   
    
    @IBAction func expandCollapse(_ sender: UIButton)
    {
        // Send the message to his delegate that shold expand or collapse
       // Show dropdown
        dropDown.show()
        self.SelGroupIndex = sender.tag
        print("more button tag->",sender.tag)
        
//        delegate?.expandableSectionHeader(self, shouldExpandOrCollapseAtSection: section)
        
        
    }
    
    // MARK: - Private Functions
    
    @objc private func didTapOnLabel(_ sender: UIGestureRecognizer) {
        // Send the message to his delegate that was selected
        delegate?.expandableSectionHeader(self, shouldExpandOrCollapseAtSection: section)
        delegate?.expandableSectionHeader(self, wasSelectedAtSection: section)
    }

   
    
}
