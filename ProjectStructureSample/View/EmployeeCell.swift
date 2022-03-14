//
//  EmployeeCell.swift
//  ProjectStructureSample
//
//  Created by MAC OS 13 on 11/03/22.
//

import UIKit

class EmployeeCell: UITableViewCell {

    @IBOutlet weak var lblEmplyeeName: UILabel!
    @IBOutlet weak var lblEmployeeAge: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    func configure(withEmployee employee: Employee)  {
        self.lblEmplyeeName.text = employee.employeeName
        self.lblEmployeeAge.text = "\(employee.employeeAge)"
    }
    
}
