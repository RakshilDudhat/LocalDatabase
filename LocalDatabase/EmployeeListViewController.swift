//
//  employeeListViewController.swift
//  LocalDatabase
//
//  Created by Rahul on 11/02/23.
//

import UIKit

class EmployeeListViewController: UIViewController {
    
    @IBOutlet weak var employeeTableView: UITableView!
    var arrEmployee: [Employee] = []

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension EmployeeListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrEmployee.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        cell.textLabel?.text = "\(arrEmployee[indexPath.row].name) \n\(arrEmployee[indexPath.row].address) \n\(arrEmployee[indexPath.row].salary)"
        cell.textLabel?.numberOfLines = 0
        return cell 
    }
}
