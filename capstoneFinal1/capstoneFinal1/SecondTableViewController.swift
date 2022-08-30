//
//  SecondTableViewController.swift
//  capstoneFinal1
//
//  Created by AlenaziHazal on 02/02/1444 AH.
//

import UIKit

class SecondTableViewController: UITableViewController {
    @IBOutlet weak var savePrees: UIBarButtonItem!
    @IBOutlet weak var notes: UITextView!
    @IBOutlet weak var dueDate: UILabel!
    @IBOutlet weak var DueDateOutlet: UIView!
    @IBOutlet weak var datePiker: UIDatePicker!
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var isCompleted: UIButton!
    var todo:ToDo?
    override func viewDidLoad() {
        super.viewDidLoad()
        notes.layer.cornerRadius = 16
        dueDate.layer.cornerRadius = 16
        datePiker.layer.cornerRadius = 16
        taskTitle.layer.cornerRadius = 16
        DueDateOutlet.layer.cornerRadius = 16
        let correntDueDate:Date
        if let todo = todo {
            navigationItem.title = "To-Do"
            taskTitle.text = todo.title
            isCompleted.isSelected = todo.isComplete
            correntDueDate = todo.duwDate
            notes.text = todo.notes
        }else {
            correntDueDate = Date().addingTimeInterval(24*60*60)
        }
        updateDueDate(date: correntDueDate)
        datePiker.date = correntDueDate
        updateSavePress()
    }
    func updateDueDate(date: Date){
        dueDate.text = date.formatted(.dateTime.month(.defaultDigits).day().year(.twoDigits).hour().minute())
    }
    func updateSavePress(){
        let shouldSave = taskTitle.text?.isEmpty == false
        savePrees.isEnabled = shouldSave
    }

    @IBAction func textEditor(_ sender: UITextField) {
        updateSavePress()
    }
    @IBAction func retrunPress(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func ComplatedPress(_ sender: UIButton) {
        isCompleted.isSelected.toggle()
    }
    @IBAction func datePicker(_ sender: UIDatePicker) {
        updateDueDate(date: sender.date)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "unWindSave" else{return}
        
        let title = taskTitle.text!
        let complated = isCompleted.isSelected
        let dueDate = datePiker.date
        let note = notes.text
        todo = ToDo(title: title, isComplate: complated, dueDate: dueDate, notes: note!)
    }
//    @IBSegueAction func editeTodo1(_ coder: NSCoder,sender: Any?) -> SecondTableViewController? {
//        let deitals = SecondTableViewController(coder: coder)
//        guard let cell = sender as? UITableViewCell,
//              let indexPath = tableView.indexPath(for: cell)   else {
//            return deitals
//            }
//        tableView.deselectRow(at: indexPath, animated: true)
//        deitals?.todo = [indexPath.row]
////
////        return deitals
//    }
    
    
    // MARK: - Table view data sourc
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
