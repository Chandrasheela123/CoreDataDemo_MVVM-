//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Shridevi Sawant on 28/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    // strong reference of viewmodel
    let empVM = EmployeeVM()

    @IBOutlet weak var tbl: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("Home Dir: \(NSHomeDirectory())")
        print("Got directory")
        
        
       // empList = getAllEmployees()
        
        empVM.getEmp()
        
        print("Total emps: \(empVM.empList.count)")
        
        tbl.dataSource = self
        tbl.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addBtnSelected))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteBtnSelected))
        
        navigationItem.title = "CapGemini"
    }

    @IBAction func filterClicked(_ sender: Any) {
        
        // filter emp by city name
        
        //empList = getEmpFilterByCity(cityName: "Bangalore")
       // empList = getEmpFilterBySalary(salary: 9000)
        
        empVM.filterBySalary(minSalary: 1000)
        tbl.reloadData()
    }
    @IBAction func sortClicked(_ sender: Any) {
        
        //empList = getEmpSortByName()
       // empList = getEmpSortBySalary()
        
        
        empVM.sortEmpBySal()
        tbl.reloadData()
        
    }
    @objc func deleteBtnSelected(){
        // delete all employees
        
        for emp in empVM.empList {
            empVM.deleteEmp(empToDelete: emp)
        }
        empVM.empList = []
        tbl.reloadData()
    }

    @objc func addBtnSelected(){
        print("Add selected")
        // add employee
        
        // navigate to next screen
        // alertController
        
        let alertVC = UIAlertController(title: "Add Employee", message: nil, preferredStyle: .alert)
        
        alertVC.addTextField { tf in
            tf.placeholder = "Employee Name"
            tf.textColor = .blue
        }
        
        alertVC.addTextField { tf in
            tf.placeholder = "Employee ID"
            tf.textColor = .blue
        }
        
        alertVC.addTextField { tf in
            tf.placeholder = "Employee Salary"
            tf.textColor = .blue
        }
        
        alertVC.addTextField { tf in
            tf.placeholder = "Employee City"
            tf.textColor = .blue
        }
        
        let okAction = UIAlertAction(title: "ADD", style: .default) { _ in
            // add emp to db
            let empName = alertVC.textFields?[0].text ?? ""
            let empID = alertVC.textFields?[1].text ?? ""
            let empSal = alertVC.textFields?[2].text ?? ""
            let empCity = alertVC.textFields?[3].text ?? ""
            
            let id = Int(empID) ?? 0
            let sal = Int(empSal) ?? 0
            
            self.empVM.addEmp(empname: empName, id: id, empCity: empCity, sal: sal)
            
            self.empVM.getEmp()
           // self.empList = getAllEmployees()
            self.tbl.reloadData() // table refreshed
        }
        
        alertVC.addAction(okAction)
        present(alertVC, animated: false, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return empVM.empList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // get cell, bind data, return cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "empCell", for: indexPath) as! EmployeeCell
        
        let emp = empVM.empList[indexPath.row]
        
        cell.nameL.text = emp.name
        cell.cityL.text = emp.city
        cell.idL.text = "\(emp.emp_id)"
        cell.salaryL.text = "\(emp.salary)"
        
        return cell
    }
    
    
}

extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // delete emp
        let emp = empVM.empList[indexPath.row]
        
        empVM.deleteEmp(empToDelete: emp) // deleted from db
        empVM.empList.remove(at: indexPath.row)
        
        tbl.deleteRows(at: [indexPath], with: .automatic)
    }
    
}
