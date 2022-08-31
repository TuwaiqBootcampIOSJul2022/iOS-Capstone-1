import UIKit


struct InformationToAddNote : Codable {
    var noteTitle:String
    var notes:String
    var datePicker:Date
    var IsComplet:Bool
}


var list = [InformationToAddNote]()



class ViewController: UIViewController {
    
    @IBOutlet var view1: UIView!
    @IBOutlet var TableView: UITableView!
    
    var titleTask: UITextField?
    var descriptionTask: UITextField?
    
    var taskTitle:String?
    var taskDetail:String?
    var taskDatePicker:Date?
    let taskdateNew = Date.now
    var taskisComplete: Bool?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        view1.layer.cornerRadius = 16
        TableView.layer.cornerRadius=16
        
        if let myTasks = UserDefaults.standard.value(forKey: "task") as? Data{
        list = try! PropertyListDecoder().decode(Array<InformationToAddNote>.self, from: myTasks)
    }
    TableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "identifierTableCell")
}

    override func viewWillAppear(_ animated: Bool) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(list), forKey: "myTasks")
        TableView.reloadData()
    }




    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTaskDetail"{
            if let viewVC = segue.destination as? AddOfTask {
                viewVC.addNoteTitle = taskTitle
                viewVC.addNotes = taskDetail
                viewVC.addDatePicker = taskDatePicker
                viewVC.isComplet = self.taskisComplete
            }
        }
    }
}




extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "identifierTableCell", for: indexPath) as! TableViewCell
        
        let currentTask = list[indexPath.row]

        
        cell.TitelNoteLabel?.text = currentTask.noteTitle
        cell.contentView.layer.cornerRadius = 16

        
        let dateP = currentTask.datePicker
        let DatePicker = DateFormatter()
        DatePicker.dateFormat = "E"
        cell.dayLabel.text = DatePicker.string(from: dateP)
        DatePicker.dateFormat = "dd"
        cell.dateOfDayLabel.text = DatePicker.string(from: dateP)
        DatePicker.dateFormat = "MMM"
        cell.monthLabel.text = DatePicker.string(from: dateP)
        

        let DateNow = Date.now
        
        if  DateNow > dateP {
            cell.ProgessBar.progressTintColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            cell.StateLabel.text = "❌"
            cell.progess.backgroundColor = .systemGray4
        }
        else if currentTask.IsComplet{
            cell.ProgessBar.progressTintColor = #colorLiteral(red: 0.4051761031, green: 0.8323419094, blue: 0.6285870671, alpha: 1)
            cell.StateLabel.text = "✅"
            cell.progess.backgroundColor = .green

         }
        else{
            
            cell.ProgessBar.progressTintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            cell.StateLabel.text = ""
            cell.progess.backgroundColor = .white

        }
        
        return cell
    }
    

    
    
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //  complete
        let compeletActionTitle = list[indexPath.row].IsComplet ? "unComplete" : "Complete"
        
        // action swip
        let compeletAction = UIContextualAction(style: .normal, title: compeletActionTitle) {  action, indexpath, _  in
            list[indexPath.row].IsComplet.toggle()
            self.TableView.reloadData()
            UserDefaults.standard.set(try? PropertyListEncoder().encode(list), forKey: "task")
      }
        compeletAction.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)

      return UISwipeActionsConfiguration(actions: [compeletAction])
  }
    // - delete
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  action, view, _  in
            list.remove(at: indexPath.row)
            self.TableView.reloadData()
            UserDefaults.standard.set(try? PropertyListEncoder().encode(list), forKey: "task")
      }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
    




// UIAlertController
extension ViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        taskTitle = list[indexPath.row].noteTitle
        taskDetail = list[indexPath.row].notes
        taskDatePicker = list[indexPath.row].datePicker
        taskisComplete = list[indexPath.row].IsComplet
        
        
             let selectedTitleTask = list[indexPath.row].noteTitle
             let selectedDescriptionTask = list[indexPath.row].notes
             let dialogMessage = UIAlertController(title: "Edit", message: "Edit Task 🔖", preferredStyle: .alert)
             let Update = UIAlertAction(title: "Update", style: .default){ (action) in
                 let editTitleTask = self.titleTask?.text
                 let editDescriptionTask = self.descriptionTask?.text
                 list[indexPath.row].noteTitle = editTitleTask!
                 list[indexPath.row].notes = editDescriptionTask!
                 DispatchQueue.main.async {
                     UserDefaults.standard.set(try? PropertyListEncoder().encode(list), forKey: "task")
                     self.TableView.reloadData()
                 }
             }
             let cancel = UIAlertAction(title: "Cancel", style: .cancel){ (action) in
             }
        
             dialogMessage.addAction(Update)
             dialogMessage.addAction(cancel)
             dialogMessage.addTextField{(textfield) in
                 self.titleTask = textfield
                 self.titleTask?.placeholder = "Edit Title Task Here"
                 self.titleTask?.text = selectedTitleTask
             }
        
        
             dialogMessage.addTextField{(textfield) in
                 self.descriptionTask = textfield
                 self.descriptionTask?.placeholder = "Edit Description Task Here"
                 self.descriptionTask?.text = selectedDescriptionTask
             }
             self.present(dialogMessage, animated: true, completion: nil)
    }
    
}
    
    
    

