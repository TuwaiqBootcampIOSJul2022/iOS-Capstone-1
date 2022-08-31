//
//  ViewController.swift
//  ToDoList
//
//  Created by Ahmed Salah on 28/08/2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    @IBOutlet weak var TableView: UITableView!
    
    var  toDo = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.delegate = self
        TableView.dataSource = self
        
    }
    
    
    
    
    
    
    
    
    // Code for Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.LaName.text = toDo[indexPath.row]
        
        return cell
    }
    
    // code for remove cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        toDo.remove(at: indexPath.row)
        UserDefaults.standard.set(toDo, forKey: "toDo")
        tableView.reloadData()
    }
    
    
    
    

    
    // For Show Data
    override func viewDidAppear(_ animated: Bool) {
        
        let todoObject = UserDefaults.standard.object(forKey: "toDo")
        if let todoSaved = todoObject as? [String]{
            toDo = todoSaved
        }
        
        UserDefaults.standard.set(toDo, forKey: "toDo")
        TableView.reloadData()
    }
    
    
    
    // Code for Hideen Kybord
    
   
    
    

}

