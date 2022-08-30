//
//  ToDoTableViewController.swift
//  capstoneFinal1
//
//  Created by AlenaziHazal on 02/02/1444 AH.
//

import UIKit

class ToDoTableViewController: UITableViewController,ToDoDelegate {
    
      var toDos = [ToDo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedToDos = ToDo.loadToDos(){
            toDos = savedToDos
        }else{
            toDos = ToDo.loadSampleToDos()
        }
        navigationItem.leftBarButtonItem = editButtonItem
        
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            toDos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    @IBAction func unWindToDo(segue: UIStoryboardSegue){
        guard segue.identifier == "unWindSave" else {return}
        let sourceView = segue.source as! SecondTableViewController
        if let todo = sourceView.todo {
            let newIndexPath = IndexPath(row: toDos.count, section: 0)
            toDos.append(todo)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDos.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        cell.delegate = self
        let toDo = toDos[indexPath.row]
        cell.titleLabel.text = toDo.title
        cell.isComplatedButton.isSelected = toDo.isComplete
        cell.dueLabel.text = "\(toDo.duwDate.formatted(.dateTime.month(.defaultDigits).day().year(.twoDigits).hour().minute()))"
//        var content = cell.defaultContentConfiguration()
//        content.text = toDo.title
//        cell.contentConfiguration = content
        return cell
        
    }
    func checkMarkedTap(sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender){
            var toDo = toDos[indexPath.row]
            toDo.isComplete.toggle()
            toDos[indexPath.row] = toDo
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    @IBSegueAction func editToDo(_ coder: NSCoder, sender: Any?) -> SecondTableViewController? {
        let deitals = SecondTableViewController(coder: coder)
        guard let cell = sender as? UITableViewCell,
              let indexPath = tableView.indexPath(for: cell)   else {
            return deitals
            }
        tableView.deselectRow(at: indexPath, animated: true)
        deitals?.todo = toDos[indexPath.row]
        
        return deitals
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
