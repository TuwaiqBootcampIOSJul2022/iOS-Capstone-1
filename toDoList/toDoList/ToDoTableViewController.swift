


import UIKit

class ToDoTableViewController: UITableViewController , ToDoCellDelgate {
    
    var taskArray = [TaskList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedToDos = TaskList.loads(){

            taskArray = savedToDos
        }else{
            taskArray = TaskList.loadSample()
        }
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newCell", for: indexPath) as! TableViewCell
    
        cell.delegate = self
        let toDo = taskArray[indexPath.row]
        cell.secondTitle.text = toDo.title
        cell.secondDate.text = "\(toDo.dueDate.formatted(.dateTime.month(.defaultDigits).day().year(.twoDigits).hour()))"
        cell.secondCheck.isSelected = toDo.isComplete

        return cell
    }
    
    
    func checkmarkTapped(sender: TableViewCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            
            var toDo = taskArray[indexPath.row]
            toDo.isComplete.toggle()
            
            taskArray[indexPath.row] = toDo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            TaskList.saveTaskList(taskArray)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            
            taskArray.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            TaskList.saveTaskList(taskArray)
        }
    }
    
    
    @IBAction func unwindTaskList(segue:UIStoryboardSegue){
        
        guard segue.identifier == "save" else {
            print("isn't the same idenifier")
            return
        }
        
        let sourceViewController = segue.source as! secondToDoTable
        
        if let toDoList = sourceViewController.taskList{
            
            if let indexOfExistingTaskList = taskArray.firstIndex(of: toDoList){
                
                taskArray[indexOfExistingTaskList] = toDoList
                tableView.reloadRows(at: [IndexPath(row: indexOfExistingTaskList, section: 0)], with: .automatic)
            
        }else{
            
            let newIndex = IndexPath(row: taskArray.count, section: 0)
            taskArray.append(toDoList)
            tableView.insertRows(at: [newIndex], with: .automatic)
            
            }
        }
            TaskList.saveTaskList(taskArray)
    }
    
    
    @IBSegueAction func editAction(_ coder: NSCoder , sender: Any?) -> secondToDoTable? {
        
        let detail = secondToDoTable(coder: coder)
        
        guard let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell) else {return detail}
        
        tableView.deselectRow(at: indexPath, animated: true)
        detail?.taskList = taskArray[indexPath.row]
        return detail
        
    }
}

