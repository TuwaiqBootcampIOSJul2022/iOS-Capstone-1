//
//  ViewController.swift
//  BookTableView
//
//  Created by Kholoud Almutairi on 29/01/1444 AH.
//

import UIKit

class toDosVC: UIViewController {

    @IBOutlet weak var MyListTabel: UITableView!

   
    
    //var listBook = [ToDosList]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(newTodoAdd), name: NSNotification.Name(rawValue: "NewToDoAdded"), object: nil)
        // Do any additional setup after loading the view.
      
        
    
        MyListTabel.register(UINib(nibName: "CustemCell", bundle: nil), forCellReuseIdentifier: "custemCell")
        
        if let mytasks = UserDefaults.standard.value(forKey:"MyData") as? Data {

            listToDos = try! PropertyListDecoder().decode(Array<ToDosList>.self, from: mytasks )



        }
      
            
        }
    override func viewWillAppear(_ animated: Bool) {
        MyListTabel.reloadData()
    }
       
    
    @objc func newTodoAdd(notification: Notification){
        print("hello word")
        if let myTodo = notification.userInfo?["addedTodo"] as? ToDosList{
            listToDos.append(myTodo)
            MyListTabel.reloadData()
           
        }
        //MyListTabel.reloadData()
    }
    
    /*func UserDefult(){
        let encoder = JSONEncoder()
        let data = try encoder.encode(listToDos)
        UserDefaults.standard.set(data, forKey: "notes")
        
        
    }*/
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "mov", sender: indexPath.row)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mov"{
            if let VCus = segue.destination as? toDoseVC2{
                VCus.todo = listToDos[sender as! Int]
                VCus.todo = listToDos[sender as! Int]
             
                
            }}
    }
    
   
    
    
    
    /*@IBAction func topToDown(_ sender: UISegmentedControl) {
        switch SigmentSort.selectedSegmentIndex{
        case 0 : listProdect.sort(by: {$0.titel <= $1.price})
        case 1:  listProdect.sort(by: {$0.price >= $1.price})
        default:
            print("")
            
        }
        MyListTabel.reloadData()
    }*/
     
    
}


/*extension toDosVC : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        listBook = listToDos.filter({$0.titel.prefix(searchText.count) == searchText})
        serch = true
        MyListTabel.reloadData()
    
     }
    }*/

