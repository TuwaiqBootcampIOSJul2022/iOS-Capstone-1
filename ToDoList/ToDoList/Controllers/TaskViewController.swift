//
//  TaskViewController.swift
//  ToDoList
//
//  Created by Rashed Shrahili on 02/02/1444 AH.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet weak var taskTitle: UITextField!
    
    @IBOutlet weak var taskDate: UIDatePicker!
    
    
    var task:String?
    var date:Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        taskTitle.text = task
        taskDate.date = date!
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "تعديل", style: .done, target: self, action: #selector(deleteTask))
    }
    
    @objc func deleteTask() {
        
        
    }

}
