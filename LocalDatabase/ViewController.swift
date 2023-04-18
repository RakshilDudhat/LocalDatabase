//
//  ViewController.swift
//  LocalDatabase
//
//  Created by Rahul on 08/02/23.
//

import UIKit
import FMDB

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var addressTextFiled: UITextField!
    @IBOutlet weak var salaryTextFiled: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    var arrEmployee: [Employee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func saveButtonClicked(_ sender: UIButton) {
        if nameTextFiled.text?.count == 0 || addressTextFiled.text?.count == 0 || salaryTextFiled.text?.count == 0 {
            print("please enter missing details")
            return
        }
        
        let query = "INSERT INTO emp (name, address, salar) VALUES ('\(nameTextFiled.text ?? "")', '\(addressTextFiled.text ?? "")', '\(salaryTextFiled.text ?? "")');"
        
//        let query = "INSERT INTO emp (name, address, salary) VALUES ('?', '?', '?');"
//        let result = databaseObject.executeUpdate(query, withArgumentsIn: [nameTextFiled.text ?? "", addressTextFiled.text ?? "", salaryTextFiled.text ?? ""])
        print(query)
        let databaseObject = FMDatabase(path: AppDelegate.databasePath)
        if databaseObject.open() {
            let result = databaseObject.executeUpdate(query, withArgumentsIn: [])
            if result == true {
                nameTextFiled.text = ""
                addressTextFiled.text = ""
                salaryTextFiled.text = ""
                messageLabel.text = "Data saved successfully"
            } else {
                messageLabel.text = "Data is not saved successfully"
            }
        }
        
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        
//        select * from emp WHERE name = 'Rahul' and address = '120,laxminarayan soc…';
//        select name, address from emp;
//        select * from emp;
        
        let query = "select * from emp;"
//        let query = "select * from emp WHERE name = '\(nameTextFiled.text ?? "")';"
        let databaseObject = FMDatabase(path: AppDelegate.databasePath)
        if databaseObject.open() {
            let results = databaseObject.executeQuery(query, withArgumentsIn: [])
            print(results)
            arrEmployee = []
            while results!.next() == true {
                let name = results?.string(forColumn: "name") ?? ""
                let address = results?.string(forColumn: "address") ?? ""
                let salary = results?.string(forColumn: "salar") ?? ""
                let employee = Employee(name: name, address: address, salary: salary)
                arrEmployee.append(employee)
            }
            print(arrEmployee)
            
            if arrEmployee.count > 0 {
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let employeeListViewController = storyboard?.instantiateViewController(withIdentifier: "EmployeeListViewController") as! EmployeeListViewController
                employeeListViewController.arrEmployee = arrEmployee
                navigationController?.pushViewController(employeeListViewController, animated: true)
            } else {
                print("No Data Found")
            }
        }
        
    }
    
    @IBAction func updateButton(_ sender: UIButton) {
        if nameTextFiled.text?.count == 0 || addressTextFiled.text?.count == 0 || salaryTextFiled.text?.count == 0 {
            print("please enter missing details")
            return
        }
        
        let query = "UPDATE emp SET address = '\(addressTextFiled.text ?? "")', salar = '\(salaryTextFiled.text ?? "")' WHERE name = '\(nameTextFiled.text ?? "")';"
        
        print(query)
        let databaseObject = FMDatabase(path: AppDelegate.databasePath)
        if databaseObject.open() {
            let result = databaseObject.executeUpdate(query, withArgumentsIn: [])
            if result == true {
                nameTextFiled.text = ""
                addressTextFiled.text = ""
                salaryTextFiled.text = ""
                messageLabel.text = "Data updated successfully"
                
            } else {
                messageLabel.text = "Data is not updated successfully"
                
            }
            
        }
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        if nameTextFiled.text?.count == 0 || addressTextFiled.text?.count == 0 || salaryTextFiled.text?.count == 0 {
            print("please enter missing details")
            return
        }
        
        let query = "DELETE FROM emp WHERE name = '\(nameTextFiled.text ?? "")';"
        
//        let query = "DELETE FROM emp WHERE name = '\(nameTextFiled.text ?? "")' AND salary '\(salaryTextFiled.text ?? "")';"
        
//        let query = "DELETE FROM emp WHERE salary = '\(salaryTextFiled.text ?? "")';"

        print(query)
        let databaseObject = FMDatabase(path: AppDelegate.databasePath)
        if databaseObject.open() {
            let result = databaseObject.executeUpdate(query, withArgumentsIn: [])
            if result == true {
                nameTextFiled.text = ""
                addressTextFiled.text = ""
                salaryTextFiled.text = ""
                messageLabel.text = "Data deleted successfully"
                
            } else {
                messageLabel.text = "Data is not deleted successfully"
                
            }
            
        }
        
    }
    
}

struct Employee {
    var name: String
    var address: String
    var salary: String
}

