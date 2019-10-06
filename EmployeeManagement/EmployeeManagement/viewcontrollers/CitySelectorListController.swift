//
//  CitySelectorListController.swift
//  EmployeeManagement
//
//  Created by Abhishek Kumar on 06/10/19.
//  Copyright © 2019 Abhishek. All rights reserved.
//

import UIKit

protocol CitySelectDelegate: class{
    func setSelectedCity(city: String)
}

class CitySelectorListController: UITableViewController {
    
    var currentSelectedCity = ""
    let cityList = ["Delhi", "Bengaluru", "Hyderabad", "Mumbai", "Pune", "Kolkata"];
    weak var citySelectionDelegate:CitySelectDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCity", for: indexPath)
        cell.textLabel?.text = cityList[indexPath.row]
        if currentSelectedCity == cityList[indexPath.row]{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        currentSelectedCity = cityList[indexPath.row]
        citySelectionDelegate?.setSelectedCity(city: currentSelectedCity)
        dismiss(animated: true, completion: nil)
    }
}
