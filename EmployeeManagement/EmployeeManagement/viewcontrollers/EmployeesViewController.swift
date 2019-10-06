//
//  ViewController.swift
//  EmployeeManagement
//
//  Created by Abhishek Kumar on 02/10/19.
//  Copyright © 2019 Abhishek. All rights reserved.
//

import UIKit

class EmployeesViewController: UITableViewController {
    
    lazy var employeeViewModel:EmployeeViewModel = EmployeeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(dataUpdate), name: NSNotification.Name.init("DATA_CHANGED"), object: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employeeViewModel.getEmpoyeeCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell", for: indexPath)
        cell.textLabel?.text = employeeViewModel.getEmployeeName(indexPath: indexPath)
        cell.detailTextLabel?.text = employeeViewModel.getEmployeeEmail(indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    @IBAction func addNewEmployeeAction(_ sender: Any) {
        print("Add New Employee Action triggered")
        performSegue(withIdentifier: "goToNewEmployee", sender: self)
    }
}

extension EmployeesViewController{
    @objc func dataUpdate(){
        print("Data Updated")
        employeeViewModel.employees = DatabaseService.shared.fetchEmployees()
        self.tableView.reloadData()
    }
}

