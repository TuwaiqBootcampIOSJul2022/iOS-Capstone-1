//
//  ListViewController.swift
//  ToDoList
//
//  Created by NosaibahMW on 01/02/1444 AH.
//

import UIKit


let userDB = UserDefaults.standard


class ListViewController: UIViewController {

    @IBOutlet weak var listOfTasksTableView: UITableView!
        
    
    var listOfTasks:[Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listOfTasksTableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "taskCustomCell")
        
        listOfTasks = readData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        listOfTasks = readData()
        print(readData())

    }

    
    func getNowDate() -> Date{
        
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .medium
        let resultString = dateFormat.string(from: Date.now)
        let date = dateFormat.date(from: resultString)
        
        return date!
    }
    
    
    
}



extension ListViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listOfTasksTableView.dequeueReusableCell(withIdentifier: "taskCustomCell", for: indexPath) as!TaskTableViewCell
        
        //to set value of checkButton, if task is completed then button will be checked , otherwise button will not be checked
        if listOfTasks[indexPath.row].isCompleted {
            cell.checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        } else {
            cell.checkButton.setImage(UIImage(systemName: "poweroff"), for: .normal)
        }
        
        //check if date is past due then change text color to red
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .medium
        if dateFormat.date(from: listOfTasks[indexPath.row].dueDate)! < getNowDate() {

            cell.taskDueDate.textColor = #colorLiteral(red: 1, green: 0.3490196078, blue: 0.3490196078, alpha: 1)
            listOfTasks[indexPath.row].isPastDue = true
        }
        
        cell.delegate = self
        cell.index = indexPath.row
        cell.taskTitle.text = listOfTasks[indexPath.row].title
        cell.taskDueDate.text = listOfTasks[indexPath.row].dueDate
        
        return cell
    }
    
    
    
}


extension ListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailsSegue", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetailsSegue"{
            if let detailsVC = segue.destination as? TaskDetailsViewController {
                detailsVC.task = listOfTasks[sender as! Int]
            }
        }
            
            if segue.identifier == "editTaskSegue"{
                if let editVC = segue.destination as? EditTaskPopUpViewController {
                    editVC.task = listOfTasks[sender as! Int]
                    editVC.index = sender as? Int
                }
                
            }
        }
    
}




extension ListViewController: TableViewCellDelegate {
   
    func checkButtonChecked(cell: TaskTableViewCell) {
        
        if listOfTasks[cell.index!].isCompleted {
            listOfTasks[cell.index!].isCompleted = false
            writeData(tasks: listOfTasks)
            cell.checkButton.setImage(UIImage(systemName: "poweroff"), for: .normal)
        } else {
            listOfTasks[cell.index!].isCompleted = true
            writeData(tasks: listOfTasks)
            cell.checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }
    }
    
    
    func deleteButtonClicked(cell: TaskTableViewCell) {
        listOfTasks.remove(at: cell.index!)
        writeData(tasks: listOfTasks)
        listOfTasksTableView.reloadData()
    }
    
    
    
    func editButtonClicked(cell: TaskTableViewCell) {
        performSegue(withIdentifier: "editTaskSegue", sender: cell.index)
        
    }
    }
    


//read and write data from/to userDefualts
extension ListViewController{
    
    //to write an array of custom object from userDefualts
    func writeData(tasks : [Task]){
        
        do {
        // Create JSON Encoder
        let encoder = JSONEncoder()

        // Encode listOfTasks
        let temArray = try encoder.encode(tasks)

        // Write/Set Data
        userDB.set(temArray, forKey: "tasks")

    } catch {
        print("Unable to Encode Array of Tasks (\(error))")
        
    }
        
    }
    
    
    func readData() -> [Task] {
        if let data = userDB.data(forKey: "tasks") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                let tasks = try decoder.decode([Task].self, from: data)

                return tasks
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
        return []
    }
    
}
