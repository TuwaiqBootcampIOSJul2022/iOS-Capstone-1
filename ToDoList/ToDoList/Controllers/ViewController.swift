//
//  ViewController.swift
//  ToDoList
//
//  Created by Rashed Shrahili on 01/02/1444 AH.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tasksTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
        
        tasksTableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "taskCell")
        
        if !UserDefaults().bool(forKey: "setup") {
            
            UserDefaults.standard.set(true, forKey: "setup")
            UserDefaults.standard.set(0, forKey: "count")
        }
        
        updateTasks()
        
    }
    
    @IBAction func didTapAdd(_ sender: UIBarButtonItem) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "entry") as! EntryViewController
        vc.title = "مهمة جديدة"
        vc.update = {
            
            DispatchQueue.main.async {
                
                self.updateTasks()
            }
            
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateTasks() {
        
        listOfTasks.removeAll()
        
        guard let count = UserDefaults.standard.value(forKey: "count") as? Int else { return }
        
        for i in 0..<count {
            
            if let task = UserDefaults.standard.value(forKey: "task_\(i+1)") as? String, let taskDate = UserDefaults.standard.value(forKey: "taskDate_\(i+1)") as? Date{
                
                listOfTasks.append(Tasks(taskTitle: task, taskDate: taskDate, isTaskCompleted: false, isTaskLate: false))
            }
        }
        
        tasksTableView.reloadData()
    }
    
}

