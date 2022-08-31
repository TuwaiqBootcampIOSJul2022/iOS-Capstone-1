//
//  ViewController.swift
//  ListsToDo-App
//
//  Created by Hessa on 28/01/1444 AH.
//

import UIKit

class ViewController: UIViewController , ViewControllerDelegate {
    func sendDataToFirstViewController(ListArr: [mydata]) {
        ToDoLists = ListArr
        Dataencoder(ListArr: ListArr)
        tabelviewToDo.reloadData()
    }
    
    @IBOutlet weak var tabelviewToDo: UITableView!
    
    var ToDoLists = [mydata]()
    var tasksText : UITextField?
    override func viewDidLoad() {
      super.viewDidLoad()
        ReloadData()
    }
    
    func Dataencoder(ListArr: [mydata]) {
        do {
            let List = ListArr
            let encoder = JSONEncoder()
            let data = try encoder.encode(List)
            UserDefaults.standard.set(data, forKey: "List")
        } catch {
        }
    }

    func Datadecoder() -> [mydata] {
        guard let data = UserDefaults.standard.data(forKey: "List") else {
            return [mydata]()
        }
        do {
            let decoder = JSONDecoder()
            let List = try decoder.decode([mydata].self, from: data)
            return List
        } catch {

        }
        return [mydata]()
    }

    func ReloadData() {
        self.ToDoLists = Datadecoder()
        guard self.ToDoLists.count > 0 else {
            return
        }
        tabelviewToDo.reloadData()
    }

    @IBAction func AddToDo(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        let navController = UINavigationController(rootViewController: vc)
        vc.ToDoLists = self.ToDoLists
        vc.delegate = self
        present(navController, animated: true)
    }
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewCell
        let data = ToDoLists[indexPath.row]
     cell.setupcell(titel: data.taskName, dste1: data.dateDisplay)
        
        cell.contentView.layer.cornerRadius = 0.1
        cell.contentView.layer.borderWidth = 0.1
        cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
        cell.leabl.text = ToDoLists[indexPath.row].taskName
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deletitem = UIContextualAction(style: .destructive, title: "") { (action, view, completionHandelr) in
            self.ToDoLists.remove(at: indexPath.row)
            self.Dataencoder(ListArr: self.ToDoLists)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            completionHandelr(true)
        }
        
        
        deletitem.image = UIImage(named: "DeletIcon")
        return UISwipeActionsConfiguration(actions: [deletitem])
    }
    
    
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let message = UIAlertController(title: "Edit Task", message: "", preferredStyle: .alert)
        
        
        let updateTask = UIAlertAction(title: "Save", style: .default)
        { (action) in
        let updatetaskName = self.tasksText?.text!
        self.ToDoLists[indexPath.row].taskName = updatetaskName!
        self.Dataencoder(ListArr: self.ToDoLists)
        DispatchQueue.main.async {
          self.tabelviewToDo.reloadRows(at: [indexPath], with: .fade)
           }
        }
        let cancel =  UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("sdfes")
        }
        message.addTextField { (textfield) in
           self.tasksText = textfield
        textfield.text = self.ToDoLists[indexPath.row].taskName
        }
        message.addAction(updateTask)
        message.addAction(cancel)
        
        self.present(message, animated: true, completion: nil)
    }
    
}

    
    
struct mydata: Decodable,Encodable {
    var taskName : String
    var dateDisplay :String
}

extension UIColor {
    
    class func colorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }}

