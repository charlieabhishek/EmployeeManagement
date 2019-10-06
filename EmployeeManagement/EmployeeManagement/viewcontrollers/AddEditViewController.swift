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
    
    var selectedCity:String?
    var isEditMode = false
    var employeeMO:Employee?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        emailIdTextField.delegate = self
        if isEditMode{
            nameTextField.text = employeeMO?.name
            emailIdTextField.text = employeeMO?.emailId
            marriageStatusSwitch.isOn = employeeMO?.married ?? false
            selectedCityLabel.text = employeeMO?.city
            selectedCity = employeeMO?.city
        }
    }
    
    @IBAction func saveEmployeeData(_ sender: UIButton) {
        
        guard let name = nameTextField.text, let email = emailIdTextField.text, let city = selectedCity else{
            showToast(message: "Please fill out all fields", seconds: 2, backgrndColor: .red, radius: 20)
            return
        }
        if name.isEmpty || email.isEmpty || city.isEmpty {
            showToast(message: "Please fill out all fields", seconds: 2, backgrndColor: .red, radius: 20)
            return
        }
        
        if isEditMode{
            setEmployeeManagedObject(employeeMO: employeeMO, name: name, city: city, emailId: email)
        } else{
            let newEmployee = Employee(context: self.context)
            setEmployeeManagedObject(employeeMO: newEmployee, name: name, city: city, emailId: email)
        }
        
        DatabaseService.shared.saveContext()
        NotificationCenter.default.post(name: NSNotification.Name.init("DATA_CHANGED"), object: nil, userInfo: nil)
        if isEditMode{
            showToast(message: "Record Updated Successfully", seconds: 2,backgrndColor: .blue)
        }else{
            showToast(message: "Record Saved Successfully", seconds: 2,backgrndColor: .purple)
            resetUI()
        }
    }
    
    func setEmployeeManagedObject(employeeMO: Employee?, name:String, city:String, emailId:String){
        employeeMO?.name = name
        employeeMO?.city = city
        employeeMO?.emailId = emailId
        employeeMO?.married = marriageStatusSwitch.isOn
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
        self.selectedCity = nil
        self.selectedCityLabel.text = "Click here for selection"
    }
    
    
    func showToast(message:String, seconds:Double, backgrndColor: UIColor=UIColor.black, radius:CGFloat=15){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = backgrndColor
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = radius
        
        self.present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+seconds) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension AddEditViewController: CitySelectDelegate{
    func setSelectedCity(city: String) {
        self.selectedCity = city
        self.selectedCityLabel.text = city
    }
}

extension AddEditViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true;
    }
}
