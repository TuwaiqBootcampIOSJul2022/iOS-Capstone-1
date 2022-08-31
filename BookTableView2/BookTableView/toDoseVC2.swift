//
//  ViewController2.swift
//  BookTableView
//
//  Created by Kholoud Almutairi on 29/01/1444 AH.
//

import UIKit

class toDoseVC2: UIViewController {
    
    var todo : ToDosList!
    var indexMove:Int!
    @IBOutlet weak var descrLabeL1: UILabel!
    @IBOutlet weak var titelLabeL1: UILabel!
    //var image3 = ""
    //var taskDecri = ""
    @IBOutlet weak var DateToDoLabel: UILabel!
    
  // var titelTask = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //image2.image = UIImage(named:image3)
        titelLabeL1.text = todo.titel
        descrLabeL1.text = todo.descript
        DateToDoLabel.text = todo.date
    

        // Do any additional setup after loading the view.
    }
    

    @IBAction func editToDoCliec(_ sender: Any) {
        
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "moveAtherPage") as? AddNewToDosVC{
            viewController.isCreation = false
            viewController.editedTodo = todo
            navigationController?.pushViewController(viewController, animated: true)
            //viewController.isCreation = false
            
        }
        
       
        
    }
    
    
    
}
