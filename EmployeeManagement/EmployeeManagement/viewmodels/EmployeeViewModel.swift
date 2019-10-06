//
//  EmployeeViewModel.swift
//  EmployeeManagement
//
//  Created by Abhishek Kumar on 02/10/19.
//  Copyright © 2019 Abhishek. All rights reserved.
//

import Foundation
import CoreData

class EmployeeViewModel{
    var employees: [Employee]?
    let context = DatabaseService.shared.persistentContainer.viewContext
    
    init() {
        employees = DatabaseService.shared.fetchEmployees()
    }
    
    func getEmpoyeeCount()->Int{
        return employees?.count ?? 0
    }
    func getEmployeeName(indexPath:IndexPath) -> String{
        return employees?[indexPath.row].name ?? ""
    }
    func getEmployeeEmail(indexPath:IndexPath) -> String{
        return employees?[indexPath.row].emailId ?? ""
    }
}
