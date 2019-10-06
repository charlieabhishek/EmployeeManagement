//
//  DatabaseService.swift
//  EmployeeManagement
//
//  Created by Abhishek Kumar on 02/10/19.
//  Copyright © 2019 Abhishek. All rights reserved.
//

import Foundation
import CoreData

final class DatabaseService{
    static let shared = DatabaseService()
    private init(){}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EmployeeManagement")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func fetchEmployees() -> [Employee]? {
        var employees:[Employee]?
        let request:NSFetchRequest<Employee> = Employee.fetchRequest()
        do{
            employees = try persistentContainer.viewContext.fetch(request)
            if employees != nil{
                employees = employees!.sorted(by: { (emp1, emp2) -> Bool in
                    return emp1.name! < emp2.name!
                })
            }
        }catch{
            print(error.localizedDescription)
        }
        return employees
    }
    
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
