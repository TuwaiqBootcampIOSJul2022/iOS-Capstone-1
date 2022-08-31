//
//  ViewController.swift
//  toDoList
//
//  Created by Ruba on 29/01/1444 AH.
//
import UserNotifications
import UIKit

class ViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    var currentItem =  UserDefaults.standard.stringArray(forKey: "items") ?? []
    let datePicker = UIDatePicker()
     var todos = [String]()
    //var userDB = UserDefaults.standard

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.register(UINib(nibName: "checkTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        createDatePicker()
        super.viewDidLoad()
        self.todos = UserDefaults.standard.stringArray(forKey: "items") ?? []
        tableView.delegate = self
        tableView.dataSource = self
        textField1.placeholder = "Enter your new task"
       
    }
    
    func createDatePicker(){
        //datePicker.preferredDatePickerStyle = .wheels
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        textField1.textAlignment = .center
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        textField1.inputAccessoryView = toolbar
        textField1.inputView = datePicker
        datePicker.datePickerMode = .date
    }
    
    @objc func donePressed(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        self.view.endEditing(true)
        
    }
    
    @IBAction func addAct(_ sender: Any) {
        if let text = textField1.text{
            todos.append(text)
            let index = IndexPath(row: todos.count-1, section: 0)
            tableView.beginUpdates()
            tableView.insertRows(at: [index], with: .automatic)
            tableView.endUpdates()
            textField1.text = ""
            currentItem.append(text)
            UserDefaults.standard.setValue(currentItem, forKey: "items")
            tableView.reloadData()
        }
    }
    
    @IBAction func editAct(_ sender: Any) {
        tableView.isEditing = !tableView.isEditing
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! checkTableViewCell
        cell.label1.text = todos[indexPath.row]
        cell.selectionStyle = .none
        cell.checkBox.addTarget(self, action: #selector(checkMarkClicked(sender:)), for: .touchUpInside)
        UserDefaults.standard.setValue(currentItem, forKey: "items")
        return cell
    }
    
    @objc func checkMarkClicked(sender:UIButton){
        if sender.isSelected{
            sender.isSelected = false
        }else{
            sender.isSelected = true
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 71.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let vc = storyboard?.instantiateViewController(withIdentifier: "move") as? vcViewController{
            vc.date = datePicker
            vc.title1 = todos[indexPath.row]
            tableView.reloadData()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        todos.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view,completionHandler ) in
            self.todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            completionHandler(true)
           // self.userDB.removeObject(forKey: "item")
           UserDefaults.standard.removeObject(forKey: "items")
        }
        
        let favAction = UIContextualAction(style: .normal, title: "Fav") { _, _, _ in
            print("User added to fav")
        }
        
        favAction.image = UIImage.init(systemName: "heart")
        return UISwipeActionsConfiguration(actions: [deleteAction , favAction])
    
    }
}



