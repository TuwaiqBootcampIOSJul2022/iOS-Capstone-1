//
//  ViewController.swift
//  ToDo List
//
//  Created by Kholoud Almutairi on 01/02/1444 AH.
//

import UIKit
import Foundation
var Tasks  = [Task]()





class ViewController: UIViewController {
        
  
    @IBOutlet weak var MyTableView: UITableView!
    @IBOutlet weak var AdditemOutlet: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AdditemOutlet.layer.cornerRadius = 30
        
        if let mytasks = UserDefaults.standard.value(forKey:"MyData") as? Data {
            
            Tasks = try! PropertyListDecoder().decode(Array<Task>.self, from: mytasks )
            
           

        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        MyTableView.reloadData()
    }
    
    
    
    @IBAction func Additem(_ sender: Any) {
        
    }
    
    @IBAction func Edit(_ sender: Any) {
        
        MyTableView.isEditing = !MyTableView.isEditing
        
        
        
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DTtask", sender: indexPath.row)}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if let view = segue.destination as? ViewController2{
        
            view.TaskName = Tasks[sender as! Int].tasktitle
            view.Details = Tasks[sender as! Int].details
            view.dateTask = Tasks[sender as! Int].date

            
        }
        
  
       if  let vc  = segue.destination as? ViewController3 {

            vc.delegate = self }
        
        
            }}








extension ViewController : UITableViewDataSource , AddTask , ChangeButton {
    
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.Tasklabel.text = Tasks[indexPath.row].tasktitle
        cell.DateLabel.text = "\(Tasks[indexPath.row].date)"
        
        
        if Tasks[indexPath.row].checked {
            
            cell.checkBox.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            

        }else {
            
            cell.checkBox.setImage(UIImage(systemName: "square"), for: .normal)

            
            
        }
        
        if Tasks[indexPath.row].ldaet == false{
            
            
            cell.DateLabel.textColor = .black
            
            
        }else{
            
            cell.DateLabel.textColor = .red

        }
        
        
        
        cell.delegate = self
        cell.index = indexPath.row
        cell.tasks = Tasks

        return cell
    }
    
    

    func addTask(name: String , details : String , Date : String) {
        Tasks.append(Task(tasktitle: name , details: details , date : Date ))
       

        MyTableView.reloadData()
    }

    
    func ChangeButton(checked: Bool, index: Int) {
        Tasks[index].checked = checked
        MyTableView.reloadData()
    }



    
    
    
}


extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        

        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            Tasks.remove(at: indexPath.row)
            self.MyTableView.reloadData()
            UserDefaults.standard.set(try? PropertyListEncoder().encode(Tasks), forKey: "MyData")

        }

        let swipeConfiguration = UISwipeActionsConfiguration(actions: [delete] )
        return swipeConfiguration
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        Tasks.swapAt(sourceIndexPath.row , destinationIndexPath.row)
        
    }
    
    
}
