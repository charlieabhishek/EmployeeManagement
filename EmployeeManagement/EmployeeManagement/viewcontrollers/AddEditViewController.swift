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
    @IBOutlet weak var selectedCityLabel: UILabel!
    @IBOutlet weak var marriageStatusSwitch: UISwitch!
    @IBOutlet weak var anniversaryTextField: UITextField!
    
    
    var selectedCity:String?
    
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
        
        if let city = selectedCity {
            newEmployee.city = city
        }
        newEmployee.married = (anniversaryTextField.isHidden) ? false:true
                
        DatabaseService.shared.saveContext()
        NotificationCenter.default.post(name: NSNotification.Name.init("DATA_CHANGED"), object: nil, userInfo: nil)
        resetUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentCityList" {
            if let nextViewController = segue.destination as? CitySelectorListController {
                nextViewController.citySelectionDelegate = self
                nextViewController.currentSelectedCity = selectedCity ?? ""
            }
        }
    }
    
    
    @IBAction func selectCityViewButtonAction(_ sender: UIButton) {
        performSegue(withIdentifier: "presentCityList", sender:self)
    }
    
    func resetUI(){
        self.nameTextField.text = ""
        self.emailIdTextField.text = ""
        self.anniversaryTextField.text = ""
    }
    
    @IBAction func marriageRadioButtonAction(_ sender: UISwitch) {
        print("Radio Button value = \(sender.isOn)")
        anniversaryTextField.isHidden = !sender.isOn
    }
    
}

extension AddEditViewController: CitySelectDelegate{
    func setSelectedCity(city: String) {
        self.selectedCity = city
        self.selectedCityLabel.text = city
    }
}
