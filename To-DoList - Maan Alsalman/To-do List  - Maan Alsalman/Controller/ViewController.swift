//
//  ViewController.swift
//  To-do List  - Maan Alsalman
//
//  Created by Maan Abdullah on 27/08/2022.
//

import UIKit
class ViewController: UIViewController {
    //MARK: - IBOutlets:
    @IBOutlet weak var tasksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tasksTableView.reloadData()
    }
    
    //MARK: - IBActions:
    @IBAction func editBtnPressed(_ sender: UIBarButtonItem) {
        tasksTableView.isEditing = !tasksTableView.isEditing
        if sender.title == "Edit"{
            sender.title = "Done"
        }
        else{
            sender.title = "Edit"
        }
    }
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "newTaskSegue", sender: nil)
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
    }
    
    //MARK: - Methods:
     func setupTableView() {
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        tasksTableView.layer.cornerRadius = 16
        tasksTableView.register(UINib(nibName: "TaskCellTableViewCell", bundle: nil), forCellReuseIdentifier: "taskCell")
        if let savedTasks = Task.loadTasksData(){
            arrayTask = savedTasks
        }
        
    }
    
    @objc func isCompletedBtnPressed(_ sender: UIButton) {
        var task  = arrayTask[sender.tag]
        task.isCompleted.toggle()
        arrayTask[sender.tag] = task
        tasksTableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
        Task.saveTasksData(arrayTask)
    }
    
    
    //MARK: - Passing Data:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "newTaskSegue" else{ return }
        guard let disTemp = segue.destination as? NewTaskTableViewController else {return}
        guard let rowTemp = sender as? IndexPath else{ return }
        disTemp.currentRow = rowTemp.row
        disTemp.isEditingCell = true
        disTemp.data = arrayTask[rowTemp.row]
        tasksTableView.deselectRow(at: rowTemp, animated: true)
        
    }
}


// MARK: - Adopt & Comfort to UITableViewDataSource, and UITableViewDelegate

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arrayTask.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCellTableViewCell
    let taskData = arrayTask[indexPath.row]
    cell.taskTitleLabel.text = taskData.title
    cell.isCompletedBtn.isSelected = taskData.isCompleted
    cell.isCompletedBtn.tag = indexPath.row
    cell.isCompletedBtn.addTarget(self, action: #selector(isCompletedBtnPressed), for: .touchUpInside)
    cell.checkDueDate(dueDate: taskData.dueDate)
    return cell
}
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            arrayTask.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            Task.saveTasksData(arrayTask)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "newTaskSegue", sender: indexPath)
    }
    
}
