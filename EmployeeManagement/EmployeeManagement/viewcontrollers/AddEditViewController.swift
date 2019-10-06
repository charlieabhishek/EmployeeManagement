//
//  AddEditViewController.swift
//  EmployeeManagement
//
//  Created by Abhishek Kumar on 02/10/19.
//  Copyright © 2019 Abhishek. All rights reserved.
//

import UIKit
import CoreData

class AddEditViewController: UIViewController {
    
    let context = DatabaseService.shared.persistentContainer.viewContext

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var marriedTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveEmployeeData(_ sender: UIButton) {
        let newEmployee = Employee(context: self.context)
        if let name = nameTextField.text{
            newEmployee.name = name
        }
        if let email = emailIdTextField.text{
            newEmployee.emailId = email
        }
        if let city = cityTextField.text{
            newEmployee.city = city
        }
        if let marriedStatus = marriedTextField.text{
            if marriedStatus.lowercased() == "yes"{
                newEmployee.married = true
            }else{
                newEmployee.married = false
            }
        }
        DatabaseService.shared.saveContext()
        NotificationCenter.default.post(name: NSNotification.Name.init("DATA_CHANGED"), object: nil, userInfo: nil)
        resetUI()
    }
    
    func resetUI(){
        self.nameTextField.text = ""
        self.emailIdTextField.text = ""
        self.cityTextField.text = ""
        self.marriedTextField.text = ""
    }
}
