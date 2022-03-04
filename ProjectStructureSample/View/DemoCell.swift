//
//  DemoCell.swift
//  ProjectStructureSample
//
//  Created by  MAC OS 19 on 19/11/1400 AP.
//

import UIKit

class DemoCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    
    
    
    
    func configure(withUser user: User)  {
        self.textLabel?.text = user.name
        self.detailTextLabel?.text = user.email
    }

    
    
}
