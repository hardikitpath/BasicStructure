//
//  ViewController.swift
//  ProjectStructureSample
//
//  Created by  MAC OS 19 on 19/11/1400 AP.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tbl: UITableView!
    
    
    var userDataSource: [User] = [User]() {
        didSet {
            self.tbl.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbl.registerNib(DemoCell.self)
        self.tbl.dataSource = self
        getUsers()
       
    }

    func getUsers()  {
        User.getUsers { result in
            switch result {
            case .success(let users):
                self.userDataSource = users
            case .failure(let error):
                print(error.title)
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
        if let cell = tableView.dequeueReuseableCell(DemoCell.self, at: indexPath) {
            cell.configure(withUser: self.userDataSource[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

