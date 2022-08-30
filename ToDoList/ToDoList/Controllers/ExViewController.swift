//
//  ExViewController.swift
//  ToDoList
//
//  Created by Rashed Shrahili on 01/02/1444 AH.
//

import UIKit

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        listOfTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        
        cell.taskTitle.text = listOfTasks[indexPath.row].taskTitle
        cell.taskDate.text = "\(listOfTasks[indexPath.row].taskDate)"
        if listOfTasks[indexPath.row].isTaskLate == false {
            
            cell.taskLate.text = "لم يفت موعدها"
            
        } else {
            
            cell.taskLate.text = "فاتت موعدها"
        }
        
        cell.taskComplete.tag = indexPath.row + 1
        
        return cell
        
    }
    
    
    
}

extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "task") as! TaskViewController
        vc.title = "تعديل المهمة"
        vc.task = listOfTasks[indexPath.row].taskTitle
        vc.date = listOfTasks[indexPath.row].taskDate
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            tableView.beginUpdates()
            listOfTasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
            
        }
    }
}
