//
//  ViewController.swift
//  ProjectStructureSample
//
//  Created by  MAC OS 19 on 19/11/1400 AP.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tbl: UITableView!
    
    
    var userDataSource: [Employee] = [Employee]() {
        didSet {
            self.tbl.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbl.registerNib(EmployeeCell.self)
        self.tbl.rowHeight = UITableView.automaticDimension
        self.tbl.estimatedRowHeight = 80
        self.tbl.dataSource = self
//        getUsers()
        getEmployee()
       
    }

//    func getUsers()  {
//        User.getUsers { result in
//            switch result {
//            case .success(let users):
////                self.userDataSource = users
//            case .failure(let error):
//                print(error.title)
//            }
//        }
//    }
    func getEmployee() {
        Employee.getEmployee { result in
            switch result {
            case .success(let employee):
                self.userDataSource = employee
            case .failure(let error):
                print(error)
            }
        }
    }
    

}

//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userDataSource.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReuseableCell(EmployeeCell.self, at: indexPath) {
            let employee = self.userDataSource[indexPath.row]
            cell.configure(withEmployee: employee)
            return cell
        }
        return UITableViewCell()
    }
}

