//
//  ViewController.swift
//  ToDoListApp
//  Created by Waad Alowain on 30/08/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
   
    var tasks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tasks"
        tableView.delegate = self
        tableView.dataSource = self
        
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
        updateTasks()
    }
    //------------------------------------------------
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @IBAction func checkbox(_ sender: UIButton) {
        if  sender.currentImage == UIImage(systemName: "checkmark.circle")
        {
            sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }
        else
        {
            sender.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        }
    }
    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        if editingStyle == .delete
//        {
//            tasks.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            self.tableView.reloadData()
//        }
//
//    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let deleteButton = UITableViewRowAction(style: .normal, title: "Delete") {
            (rowAction ,indexPath) in

            self.tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()

            }
        deleteButton.backgroundColor = UIColor.systemRed

        let editButton = UITableViewRowAction(style: .normal, title: "Edit"){
                (rowAction ,indexPath) in
            print("edit Button")
            }
        editButton.backgroundColor = UIColor.systemGreen
        return [editButton, deleteButton]
        }
    

    //-------------------------------------------------
    func updateTasks() {
        
        tasks.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        for x in 0..<count {
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                tasks.append(task)
            }
        }
        
        tableView.reloadData()
    }

    @IBAction func didTapAdd() {
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        
        vc.title = "New Task"
        vc.update = {
            DispatchQueue.main.async {
            self.updateTasks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }

}


extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
        let vc = storyboard?.instantiateViewController(identifier: "task") as! TaskViewController
        
        vc.title = "New Task"
        vc.task = tasks[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tasks[indexPath.row]
        
        return cell
    }
}
