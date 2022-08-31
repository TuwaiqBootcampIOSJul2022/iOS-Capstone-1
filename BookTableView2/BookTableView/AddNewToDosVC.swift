//
//  AddNewToDosVC.swift
//  BookTableView
//
//  Created by user on 03/02/1444 AH.
//

import UIKit

let userDB = UserDefaults.standard
class AddNewToDosVC: UIViewController {
    
    var isCreation = true
    var editedTodo: ToDosList?
    
    

    @IBOutlet weak var cheangBouton: UIButton!
    @IBOutlet weak var detelsViewText: UITextView!
    @IBOutlet weak var titelTextFild: UITextField!
    
    @IBOutlet weak var dateTextFile: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titelTextFild.text = ""
        detelsViewText.text = ""
        
        if isCreation == false {
            cheangBouton.setTitle("Edit", for: .normal)
            navigationItem.title = "Edit Task"
            
            if let toDo = editedTodo{
                titelTextFild.text = toDo.titel
                detelsViewText.text = toDo.descript
                dateTextFile.text = toDo.date
            }
        }
       

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addnewTask(_ sender: Any) {
        
       /*if defTextView.text != nil || !(defTextView.text == "")  {

            print(definitionName)

        } else {

            print("nil")

        }*/
        
        if titelTextFild.text != "" {
           /* guard let countTask = UserDefaults.standard.value(forKey: "count") as? Int else{return}
            let newCountTask = countTask + 1
            UserDefaults.standard.set(newCountTask, forKey: "count")
            UserDefaults.standard.set(titelTextFild, forKey: "\(newCountTask)")
            UserDefaults.standard.set(dateTextFile, forKey: "\(newCountTask)")
            update?()*/
            
        
        if isCreation == true{
            var todo = ToDosList(titel: titelTextFild.text!, descript: detelsViewText.text!, date: dateTextFile.text!)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NewToDoAdded"), object: nil, userInfo: ["addedTodo" : todo])
            
            let aler = UIAlertController(title: "upDate", message: "Done update task successfully", preferredStyle: UIAlertController.Style.alert)
            let doneAction = UIAlertAction(title: "Done", style: UIAlertAction.Style.cancel) { _ in
                self.tabBarController?.selectedIndex = 0
            }
            aler.addAction(doneAction)
            present(aler, animated: true, completion: nil)
            
            titelTextFild.text = ""
            detelsViewText.text = ""
            
            
        }
            else{
                //
            }
        } else{
            print("Please write Titel")
        }
        
    }
    
 
    

    
    

}
