//
//  EmployeeVM.swift
//  CoreDataDemo
//
//  Created by cdp on 02/06/22.
//

import Foundation

class EmployeeVM {
    
    // strong reference of model
    // all functions are enclosed in DBUtility() class in DBUtilities file
    let dbUtility = DBUtility()
    var empList : [Employee] = []
    
    func addEmp(empname: String, id: Int, empCity: String, sal: Int) {
        
        // call function using object dbUtility
        dbUtility.addEmployee(name: empname, empId: id, city: empCity, salary: sal)
        
    }
    
    func getEmp() {
        
        // store employees in empList
        empList = dbUtility.getAllEmployees()
        
    }
    
    func deleteEmp(empToDelete: Employee){
        
        dbUtility.deleteEmp(emp: empToDelete)
        
    }
    
    func sortEmpByName(){
        
       empList = dbUtility.getEmpSortByName()
        
    }
    func sortEmpBySal(){
        empList = dbUtility.getEmpSortBySalary()
        
    }
    
    func filterByCity(city: String){
        
        empList = dbUtility.getEmpFilterByCity(cityName: city)
        
    
    }
    
    func filterBySalary(minSalary: Int){
        
        empList = dbUtility.getEmpFilterBySalary(salary: minSalary)
        
    }
}
